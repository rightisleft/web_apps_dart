import 'dart:async';
import 'mongo_model.dart';
import 'package:tickets/shared/schemas.dart';
import 'package:tickets/db/db_config.dart';
import 'package:dartson/dartson.dart';


class TicketingModel extends Object {
  MongoModel _mongo;

  TicketingModel() {
    DbConfigValues config = new DbConfigValues();
    _mongo = new MongoModel(config.dbName, config.dbURI, config.dbSize);
  }

  Future createPurchase(Map params) async {
    var dson = new Dartson.JSON();
    PurchaseDTO purchaseDTO = dson.map(params, new PurchaseDTO() );

    TransactionDTO tDTO = new TransactionDTO();
    tDTO.paid = 1000;  //we're faking a successful creditcard payment
    tDTO.user = purchaseDTO.pEmail;
    await _mongo.createByItem(tDTO);
    purchaseDTO.transactionId = tDTO.id.toString();
    return _mongo.createByItem(purchaseDTO);
  }

  Future getAllCities(Map params) {
    return _mongo.readCollectionByType(CityDTO);
  }

  Future getAllTimes(Map params) {
    return _mongo.readCollectionByType(TimeDTO);
  }

  Future getTimesByCity(Map params) async {
    Map queryTime = {'arrival': params['cityArrival'], 'departure': params['cityDepart']};
    List<TimeDTO> time_dtos;
    time_dtos = await _mongo.readCollectionByType(TimeDTO, queryTime);
    Map queryRoutes = {'route': params['cityDepart']+"_"+params['cityArrival'] };
    return _mongo.readCollectionByType(RouteDTO, queryRoutes).then((List rdtos) {
      time_dtos.forEach((TimeDTO dto) => dto.route = rdtos.first);
      return time_dtos;
    });
  }

  Future getTimesByFlightNumber(Map params) async {
    List<TimeDTO> time_dtos;
    time_dtos = await _mongo.readCollectionByType(TimeDTO, {'flight': int.parse(params['flight'])} );
    var query = {'route': time_dtos.first.departure + "_" + time_dtos.first.arrival};
    return _mongo.readCollectionByType(RouteDTO, query).then((List rdtos) {
      time_dtos.forEach((TimeDTO dto) => dto.route = rdtos.first);
      return time_dtos;
    });
  }
}
