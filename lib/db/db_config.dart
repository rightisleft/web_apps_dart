class DbConfigValues {
  String dbName = 'Tickets';
  String dbURI = 'mongodb://127.0.0.1/';
  String dbSeed = "../lib/db/seed.json";
  int dbSize = 10;

  String get testDbName => dbName + "Test";
  String get testDbURI => dbURI;
  String get testDbSeed => dbSeed;
  int get testDbSize => dbSize;
}