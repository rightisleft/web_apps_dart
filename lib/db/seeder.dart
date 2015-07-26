import 'dart:io';
import 'dart:async';
import '../../packages/json_object/json_object.dart';
import '../../packages/mongo_dart/mongo_dart.dart';

main() {
  var importer = new Seeder('Tickets', 'mongodb://127.0.0.1/', 'bin/db/seed.json');
  importer.readFile();
}

class Seeder {
  final String _dbURI;
  final String _dbName;
  final String _dbSeedFile;

  Seeder(String this._dbName, String this._dbURI, String this._dbSeedFile);

  void readFile() {
    File aFile = new File(_dbSeedFile);
    aFile.readAsString()
    .then((String item) => new JsonObject.fromJsonString(item))
    .then(printJson)
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
    Db database = new Db('mongodb://rightisleft:Lecnac55@ds063892.mongolab.com:63892/rightisleft-dart');
    await database.open();
    await Future.forEach(json.keys, (String collectionName) {
      DbCollection collection = new DbCollection(database, collectionName); //grabs the collection instance
      collection.insertAll(json[collectionName]);
      //takes a list of maps and writes to a collection
    });
    return database;
  }

  void closeDatabase(Db database) {
    database.close().then((_) {
      exit(0);
    });
  }
}
