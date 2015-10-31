library database_configuration;

import 'dart:io';

class DbConfigValues {
  String dbName = 'rightisleft-dart';
  String dbURI = Platform.environment['TICKET_DB_URI'];
  Resource dbSeed = const Resource('package:tickets/db/seed.json');
  int dbSize = 10;

  String get testDbName => dbName + "-test";
  String get testDbURI => Platform.environment['TICKET_DB_URI_TEST'];
  Resource get testDbSeed => dbSeed;
  int get testDbSize => dbSize;
}
