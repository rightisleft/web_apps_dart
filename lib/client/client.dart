library ticket_client;

import 'dart:async';
import 'dart:html';

//pub
import 'package:json_object/json_object.dart';
import 'package:angular2/angular2.dart';
import 'package:angular2/bootstrap.dart';
import 'package:angular2/router.dart';
import 'package:angular2/directives.dart';
import 'package:angular2/di.dart';

import 'package:dartson/dartson.dart';

//shared
import 'package:tickets/shared/schemas.dart';

part 'package:tickets/client/services/shared_data.dart';

part 'tickets.dart';
part 'components/flight_display/flight_display.component.dart';
part 'components/landing/landing.component.dart';
part 'components/order/order-form.component.dart';
part 'components/order/recap.component.dart';
part 'components/picker/picker.component.dart';
part 'components/search/search_component.dart';
part 'components/topnav/topnav.component.dart';
part 'services/query_service.dart';

part 'composite_views/viewflights.component.dart';


const List<Type> client_classes = const [Topnav, Tickets, Landing, BaseDTO, ViewFlights, FlightDisplay,  SearchBox, OrderForm, Recap, Picker, FlightQueryService];