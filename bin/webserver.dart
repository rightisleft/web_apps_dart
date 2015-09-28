import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_route/shelf_route.dart';

import 'dart:io';
import 'package:path/path.dart';
import 'package:shelf_static/shelf_static.dart';

import 'ticketing_controller.dart' as controller;
import 'package:logging/logging.dart';

main() async {

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });

  var path = Platform.script.toFilePath();
  var currentDirectory = dirname(path);
  var fullPath  = join(currentDirectory, '..', 'build/web');

  pritn('fullPath: ' + fullPath);
  var buildPath  = join(currentDirectory, '..', 'build');

  pritn('buildPath: ' + buildPath);

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
  Cascade cc = new Cascade().add(apiHandler);

  // if missing build directory... don't serve it
  // this enables localhost debugging
  if( await new Directory(buildPath).exists() )
  {
    print('serve build');
    Handler fHandler  = createStaticHandler(fullPath , defaultDocument: 'index.html');
    cc.add(fHandler);
  }

  int http_port = int.parse(Platform.environment['PORT']);

  io.serve(cc.handler, '0.0.0.0',  http_port)
      .then( (HttpServer server) => print( 'http serving on: ' + server.port.toString() ));
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
