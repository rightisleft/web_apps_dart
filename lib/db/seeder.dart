import 'dart:io';
import 'dart:async';
import 'package:json_object/json_object.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'db_config.dart';

main() {
  DbConfigValues config = new DbConfigValues();
  var importer = new Seeder(config.dbName, config.dbURI, config.dbSeed);
  importer.readFile();
}

class Seeder {
  final String _dbURI;
  final String _dbName;
  final String _dbSeedFile;

  Seeder(String this._dbName, String this._dbURI, String this._dbSeedFile);

  Future readFile() {
    File aFile = new File(_dbSeedFile);
    return aFile.readAsString()
        .then((String item) => new JsonObject.fromJsonString(item))
        .then(insertJsonToMongo)
        .then(closeDatabase);
  }

  JsonObject printJson(JsonObject json) {
    json.keys.forEach((String collectionKey) {
      print('Collections Name: ' + collectionKey);
      var collection = json[collectionKey];
      print('Collection: ' + collection.toString());
      collection.forEach((document) {
        print('Document: ' + document.toString());
      });
    });
    return json;
  }

  Future<Db> insertJsonToMongo(JsonObject json) async
  {
    Db database = new Db(_dbURI + _dbName);
    await database.open();
    await Future.forEach(json.keys, (String collectionName) async {

      //grabs the collection instance
      DbCollection collection = new DbCollection(database, collectionName);

      //takes a list of maps and writes to a collection
      return collection.insertAll(json[collectionName]);
    });
    return database;
  }

  Future closeDatabase(Db database) {
    return database.close();
  }
}
