import 'dart:html';
import 'dart:async';

import 'package:angular2/angular2.dart';
import 'package:angular2/bootstrap.dart';
import 'package:angular2/di.dart';
import 'package:angular2/router.dart';
import 'package:tickets/client/client.dart';

void main() {
  bootstrap(Tickets, [
    routerInjectables,
    bind(APP_BASE_HREF).toValue('/web_apps_dart'),
    client_classes,
  ]);
}