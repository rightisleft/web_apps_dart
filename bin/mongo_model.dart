library ticket_models;

import 'dart:async';
import 'package:tickets/shared/schemas.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:connection_pool/connection_pool.dart';
import 'mongo_pool.dart';
import "dart:mirrors";

class MongoModel {

  MongoPool _dbPool;

  MongoModel(String _databaseName, String _databaseUrl, int _databasePoolSize) {
    _dbPool = new MongoPool(_databaseUrl + _databaseName, _databasePoolSize);
  }

  Future<Map> createByItem(BaseDTO item) {
    assert(item.id == null);
    item.id = new ObjectId();
    return _dbPool.getConnection().then((ManagedConnection mc) {
      Db db = mc.conn;
      DbCollection collection = db.collection(item.collection_key);
      Map aMap = dtoToMongoMap(item);
      return collection.insert(aMap).then((status) {
        _dbPool.releaseConnection(mc);
        return (status['ok'] == 1) ? item : status;
      });
    });
  }

  Future<Map> deleteByItem(BaseDTO item) {
    assert(item.id != null);
    return _dbPool.getConnection().then((ManagedConnection mc) {
      Db database = mc.conn;
      DbCollection collection = database.collection(item.collection_key);
      Map aMap = dtoToMongoMap(item);
      return collection.remove(aMap).then((status) {
        _dbPool.releaseConnection(mc);
        return status;
      });
    });
  }

  Future<BaseDTO> readItemByItem(BaseDTO matcher) {
    assert(matcher.id != null);
    Map query = {'_id': matcher.id};
    BaseDTO bdto;
    return _getCollection(matcher.collection_key, query).then((items) {
      bdto = mapToDto(getInstance(matcher.runtimeType), items.first);
      return bdto;
    });
  }

  Future<List> readCollectionByTypeWhere(t, fieldName, values) {
    List list = new List();
    BaseDTO freshInstance = getInstance(t);
    return _getCollectionWhere(freshInstance.collection_key, fieldName, values).then((items) {
      items.forEach((item) {
        list.add(mapToDto(getInstance(t), item));
      });
      return list;
    });
  }

  Future<List> readCollectionByType(t, [Map query = null]) {
    List list = new List();
    BaseDTO freshInstance = getInstance(t);
    return _getCollection(freshInstance.collection_key, query).then((items) {
      items.forEach((item) {
        list.add(mapToDto(getInstance(t), item));
      });
      return list;
    });
  }

  Future<Map> updateItem(BaseDTO item) {
    assert(item.id != null);
    return _dbPool.getConnection().then((ManagedConnection mc) async {
      Db database = mc.conn;
      DbCollection collection = new DbCollection(database, item.collection_key);
      Map selector = {'_id': item.id};
      Map newItem = dtoToMongoMap(item);
      return await collection.update(selector, newItem).then((_) {
        _dbPool.releaseConnection(mc);
        return _;
      });
    });
  }

  Future<Map> dropDatabase() async {
    Db database = await _dbPool.openNewConnection();
    Map status = await database.drop();
    return status;
  }

  // Some Abstractions

  Future<List> _getCollectionWhere(String collectionName, fieldName, values) {
    return _dbPool.getConnection().then((ManagedConnection mc) async {
      Db database = mc.conn;
      DbCollection collection = new DbCollection(database, collectionName);
      SelectorBuilder builder = where.oneFrom(fieldName, values);
      return await collection.find( builder ).toList().then((map) {
        _dbPool.releaseConnection(mc);
        return map;
      });
    });
  }

  Future<List> _getCollection(String collectionName, [Map query = null]) {
    return _dbPool.getConnection().then((ManagedConnection mc) async {
      DbCollection collection = new DbCollection(mc.conn, collectionName);
      List<Map> list = await collection.find(query).toList();
      _dbPool.releaseConnection(mc);
      return list;
    });
  }

  dynamic getInstance(Type t) {
    MirrorSystem mirrors = currentMirrorSystem();
    LibraryMirror lm = mirrors.libraries.values.firstWhere(
        (LibraryMirror lm) => lm.qualifiedName == new Symbol('ticket_schemas'));
    ClassMirror cm = lm.declarations[new Symbol(t.toString())];
    InstanceMirror im = cm.newInstance(new Symbol(''), []);
    return im.reflectee;
  }

  dynamic mapToDto(cleanObject, Map document) {
    var reflection = reflect(cleanObject);
    document['id'] = document['_id'];
    document.remove('_id');
    document.forEach((k, v) {
      reflection.setField(new Symbol(k), v);
    });
    return cleanObject;
  }

  Map dtoToMap(Object object) {
    var reflection = reflect(object);
    Map target = new Map();
    var type = reflection.type;

    while (type != null) {
      type.declarations.values.forEach((item) {
        if (item is VariableMirror) {
          VariableMirror value = item;
          if (!value.isFinal) {
            target[MirrorSystem.getName(value.simpleName)] = reflection.getField(value.simpleName).reflectee;
          }
        };
      });
      type = type.superclass;
      // get properties from superclass too!
    }

    return target;
  }

  Map dtoToMongoMap(object) {
    Map item = dtoToMap(object);

    // mongo uses an underscore prefix which would act as a private field in dart
    // convert only on write to mongo

    item['_id'] = item['id'];
    item.remove('id');
    return item;
  }
}
