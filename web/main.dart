import 'package:angular2/angular2.dart';
import 'package:angular2/bootstrap.dart';
import 'package:angular2/di.dart';
import 'package:angular2/router.dart';
import 'package:tickets/client/client.dart';
import 'dart:html';

void main() {

  // acquire config parameters from transformer
  Element parent = querySelector('tickets');
  EnvironmentVariables.PORT = int.parse(parent.attributes['port']);
  EnvironmentVariables.DART_ENV = parent.attributes['environment'];

  var appComponent = Tickets;
  var inejectableBindings = [ ROUTER_BINDINGS, client_classes,
                            bind(APP_BASE_HREF).toValue('/'),
                            bind(LocationStrategy).toClass(HashLocationStrategy)];

  bootstrap(appComponent, inejectableBindings);
}
