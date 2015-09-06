import 'package:angular2/angular2.dart';
import 'package:angular2/bootstrap.dart';
import 'package:angular2/di.dart';
import 'package:angular2/router.dart';
import 'package:tickets/client/client.dart';

void main() {
  print('-- Main.dart 2 --');
  bootstrap(Tickets, [
    routerInjectables,
    client_classes,
    bind(APP_BASE_HREF).toValue('/'),
    bind(LocationStrategy).toClass(HashLocationStrategy)
  ]);
}