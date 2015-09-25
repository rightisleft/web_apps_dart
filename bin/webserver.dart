import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_route/shelf_route.dart';

import 'dart:io';
import 'package:path/path.dart';
import 'package:shelf_static/shelf_static.dart';

import 'ticketing_controller.dart' as controller;
void main() {

  var path = Platform.script.toFilePath();
  var currentDirectory = dirname(path);
  var fullPath  = join(currentDirectory, '..', 'build/web');
  Handler fHandler  = createStaticHandler(fullPath , defaultDocument: 'index.html');

  Router primaryRouter = router();
  Router api = primaryRouter.child('/tickets');
  api.add('/flight/{flight}', ['GET'], controller.handleFlightNumber);
  api.add('/cities', ['GET'], controller.handleCities);
  api.add('/times', ['POST'], controller.handleTimesCity);
  api.add('/purchase', ['POST'], controller.handlePurchase);

  Middleware mw = logRequests();
  Pipeline pl = new Pipeline();
  pl = pl.addMiddleware(corsMiddleWare).addMiddleware(mw);
  Handler apiHandler  = pl.addHandler(primaryRouter.handler);

  Cascade cc = new Cascade().add(apiHandler).add(fHandler);

  var systemPort = Platform.environment['PORT'];
  var port = systemPort == null ? 1234 : int.parse(systemPort);

  io.serve(cc.handler, '0.0.0.0', port);
}

Map CORSHeader = {'content-type': 'text/json',
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': "Origin, X-Requested-With, Content-Type, Accept",
  'Access-Control-Allow-Methods': "POST, GET, PUT, DELETE, OPTIONS"};

Middleware corsMiddleWare = createMiddleware(requestHandler: reqHandler, responseHandler: respHandler);

Response reqHandler(Request request){
  if(request.method == "OPTIONS")
  {
    return new Response.ok(null, headers: CORSHeader);
  }
  return null; // nothing to see here... move along
}

Response respHandler(Response response) {
  return response.change(headers: CORSHeader);
}
