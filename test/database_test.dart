import 'package:guinness/guinness.dart';
import 'package:tickets/shared/schemas.dart';
import 'package:tickets/db/seeder.dart';
import 'package:tickets/db/db_config.dart';
import '../bin/mongo_model.dart';

main() {

//  Logger.root.level = Level.ALL;
//  Logger.root.onRecord.listen((LogRecord rec) {
//    print('${rec.level.name}: ${rec.time}: ${rec.message}');
//  });

  DbConfigValues config = new DbConfigValues();
  MongoModel model = new MongoModel(config.testDbName, config.testDbURI, config.testDbSize);

  //A Test DTO
  RouteDTO routeDTO = new RouteDTO()..duration=120..price1=90.00..price2=91.00..price3=95.00..seats=7;

  describe("The Ticket MongoModel", () {

    it('Should populate the Test Database', () async {
      Seeder seeder = new Seeder(config.testDbName, config.testDbURI, config.testDbSeed);
      await seeder.readFile();
      List collection = await model.readCollectionByType( RouteDTO );
      expect(collection.length).toBeGreaterThan(10);
    });

    it("should create a record DTO and write to the db", () {
      var originalID = routeDTO.id;
      return  model.createByItem(routeDTO).then(( var dto ) {
        expect(originalID).toBeNull();
        expect(routeDTO.id).toBeNotNull();
        expect(dto.id).toEqual(routeDTO.id);
      });
    });

//    it("should not allows a DTO with an id to be created again db", () {
//      var temp = new RouteDTO()..id = '123456';
//      var response;
//      try {
//        model.createByItem(temp);
//      } catch (e) {
//        expect(e).toBeAnInstanceOf(AssertionError);
//      }
//      expect(response).toBeNull();
//    });

    var action = "update previous db item, retrieve it to make sure its updated";
//    it(action, () {
//      routeDTO.price1=10000.10;
//      return model.updateItem(routeDTO).then((status) {
//        return model.readItemByItem(routeDTO).then((dto){
//          expect(status['ok']).toEqual(1.0);
//          expect(dto.price1).toEqual(routeDTO.price1);
//        });
//      });
//    });

    it(action, () async {
      routeDTO.price1=10000.10;
      var status = await  model.updateItem(routeDTO);
      var dto = await model.readItemByItem(routeDTO);
      expect(status['ok']).toEqual(1.0);
      expect(dto.price1).toEqual(routeDTO.price1);
    });

    it("will retrieive the item created in the first step", () {
      return  model.readItemByItem(routeDTO).then((BaseDTO dto){
        expect(dto.id).toEqual(routeDTO.id);
      });
    });

    it("should retrieve a list of items by the DTO", () {
      return  model.readCollectionByType( RouteDTO ).then(( List<BaseDTO> aList ) {
        expect(aList.first).toBeAnInstanceOf(RouteDTO);
        expect(aList.length).toBeGreaterThan(10);
      });
    });

    it("should delete the route DTO from the DB", () {
      return model.deleteByItem(routeDTO).then( (status) {
        expect(status['ok']).toEqual(1.0);
      });
    });

    it("should drop the test database", () async {
      Map status = await model.dropDatabase();
        expect(status['ok']).toEqual(1.0);
    });
  });
}