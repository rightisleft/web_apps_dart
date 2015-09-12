library ticket_client;

import 'dart:async';
import 'dart:html';
import 'dart:convert';

//angular2
import 'package:angular2/angular2.dart';
import 'package:angular2/bootstrap.dart';
import 'package:angular2/router.dart';
import 'package:angular2/angular2_exports.dart';

//data
import 'package:tickets/shared/schemas.dart';
import 'package:dartson/dartson.dart';

//components
part 'main.tickets.component.dart';
part 'components/flight_display/flight_display.component.dart';
part 'components/landing/landing.component.dart';
part 'components/order/order-form.component.dart';
part 'components/order/recap.component.dart';
part 'components/picker/picker.component.dart';
part 'components/topnav/topnav.component.dart';

part 'services/query_service.dart';
part 'services/shared_data.dart';

part 'composite_views/view.complete.component.dart';
part 'composite_views/view.flights.component.dart';
part 'composite_views/view.example.component.dart';
part 'composite_views/view.order.component.dart';
part 'composite_views/view.landing.component.dart';

//injectables
const List<Type> client_classes = const [ExampleComponent, ViewLanding, Landing,Topnav, Tickets, BaseDTO, ViewFlights, FlightDisplay,  OrderForm, Recap, Picker, FlightQueryService, SharedData, ViewComplete];