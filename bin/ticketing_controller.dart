library flight_controller;

import 'package:shelf/shelf.dart';
import 'package:shelf_path/shelf_path.dart' as path;
import 'ticketing_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:dartson/dartson.dart';

TicketingModel model = new TicketingModel();
var converter = new Dartson.JSON();

Future <Response> handleCities(Request request) {
  return _genericJsonHandler(model.getAllCities, request);
}

Future <Response> handleTimesCity(Request request) {
  return _genericJsonHandler(model.getTimesByCity, request);
}

Future <Response> handleFlightNumber(Request request) {
  return _genericJsonHandler(model.getTimesByFlightNumber, request);
}

Future <Response> handleTimes(Request request) {
  return _genericJsonHandler(model.getAllTimes, request);
}

Future <Response> handlePurchase(Request request) {
  return _genericJsonHandler(model.createPurchase, request);
}

Future <Response> _genericJsonHandler(Function getter, Request request) {
  return getPostParams(request)
  .then( ( params ) => getPathParams( request , params ) )
  .then( ( json ) => getter( json ) )
  .then( ( list ) => _dartsonListToJson( list ) )
  .then( makeResponse );
}

Future<Response> makeResponse( String json ) async {
  var response = new Response.ok( json );
  return response;
}

String _dartsonListToJson(payload) {
  dynamic encodable = converter.serialize(payload);
  return JSON.encode(encodable);
}

Map getPathParams(Request request, Map payload) {
  Map params = path.getPathParameters(request);
  params.forEach( (key, val) {
    payload[key] = val;
  });
  return payload;
}

Future<Map> getPostParams(Request request) {
  return request.readAsString().then( (String body) {
    return body.isNotEmpty ? JSON.decode(body) : {};
  });
}
