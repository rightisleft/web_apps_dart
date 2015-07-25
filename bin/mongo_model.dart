library ticket_models;

import 'dart:async';
import 'package:tickets/shared/schemas.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'mongo_pool.dart';
import "dart:mirrors";

class Config {
  static const String DATABASE_NAME = 'Tickets';
  static const String DATABASE_URL = 'mongodb://127.0.0.1/';
  static const String DATABASE_SEED = 'db/data/seed.json';
}

class MongoModel {

  static const String DATABASE_NAME = 'Tickets';
  static const String DATABASE_URL = 'mongodb://127.0.0.1/';
  static const int DATABASE_POOL_SIZE = 10;

  static final MongoDbPool _dbPool = new MongoDbPool(DATABASE_URL + DATABASE_NAME, DATABASE_POOL_SIZE);

  Future<Map> createByItem(BaseDTO item) async {
    assert(item.id == null);
    item.id = new ObjectId();
    return _dbPool.openNewConnection().then((Db database) {
      DbCollection collection = database.collection(item.collection_key);
      Map aMap = voToMongoMap(item);
      return collection.insert(aMap).then((_) {
        _dbPool.closeConnection(database);
        if(_['ok'] == 1)
        {
          return [item];
        } else {
          return _;
        }
      });
    });
  }

  Future<Map> deleteByItem(BaseDTO item) async {
    assert(item.id != null);
    return _dbPool.openNewConnection().then((Db database) {
      DbCollection collection = database.collection(item.collection_key);
      Map aMap = voToMongoMap(item);
      return collection.remove(aMap).then((_) {
        _dbPool.closeConnection(database);
        return _;
      });
    });
  }

  Future<BaseDTO> readItemByItem(BaseDTO matcher) async {
    assert(matcher.id != null);
    Map query = {'_id': matcher.id};
    BaseDTO bvo;
    return _getCollection(matcher.collection_key, query).then((items) {
      bvo = mapToVO(getInstance(matcher.runtimeType), items.first);
      return bvo;
    });
  }

  Future<List> readCollectionByTypeWhere(t, fieldName, values) async {
    List list = new List();
    BaseDTO freshInstance = getInstance(t);
    return _getCollectionWhere(freshInstance.collection_key, fieldName, values).then((items) {
      items.forEach((item) {
        list.add(mapToVO(getInstance(t), item));
      });
      return list;
    });
  }

  Future<List> readCollectionByType(t, [Map query = null]) async {
    List list = new List();
    BaseDTO freshInstance = getInstance(t);
    return _getCollection(freshInstance.collection_key, query).then((items) {
      items.forEach((item) {
        list.add(mapToVO(getInstance(t), item));
      });
      return list;
    });
  }

  Future<Map> updateItem(BaseDTO item) async {
    assert(item.id != null);
    return _dbPool.openNewConnection().then((Db database) async {
      DbCollection collection = new DbCollection(database, item.collection_key);
      Map selector = {'_id': item.id};
      Map newItem = voToMongoMap(item);
      return await collection.update(selector, newItem).then((_) {
        _dbPool.closeConnection(database);
        return _;
      });
    });
  }

  // Some Abstractions

  Future<List> _getCollectionWhere(String collectionName, fieldName, values) {
    return _dbPool.openNewConnection().then((Db conn) async {
      DbCollection collection = new DbCollection(conn, collectionName);
      return await collection.find( where.oneFrom(fieldName, values) ).toList().then((map) {
        _dbPool.closeConnection(conn);
        return map;
      });
    });
  }

  Future<List> _getCollection(String collectionName, [Map query = null]) {
    return _dbPool.openNewConnection().then((Db conn) async {
      DbCollection collection = new DbCollection(conn, collectionName);
      return await collection.find(query).toList().then((map) {
        _dbPool.closeConnection(conn);
        return map;
      });
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

  dynamic mapToVO(vo, Map document) {
    var reflection = reflect(vo);
    document['id'] = document['_id'];
    document.remove('_id');
    document.forEach((k, v) {
      reflection.setField(new Symbol(k), v);
    });
    return vo;
  }

  Map voToMap(Object vo) {
    var reflection = reflect(vo);
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

  Map voToMongoMap(object) {
    Map item = voToMap(object);
    // mongo uses an underscore prefix which would act as a private field in dart
    // convert only on write to mongo
    item['_id'] = item['id'];
    item.remove('id');
    return item;
  }
}


