import 'dart:io';

class DbConfigValues {
  String dbName = 'rightisleft-dart';
  String dbURI = 'mongodb://rightisleft:Lecnac55@ds063892.mongolab.com:63892/';
  Resource dbSeed = const Resource('package:tickets/db/seed.json');
  int dbSize = 10;

  String get testDbName => dbName + "-test";
  String get testDbURI => 'mongodb://rightisleft:Lecnac55@ds051843.mongolab.com:51843/';
  Resource get testDbSeed => dbSeed;
  int get testDbSize => dbSize;
}