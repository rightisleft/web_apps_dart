library ticket_client;

import 'dart:async';
import 'dart:html';
import 'dart:convert';

//angular2
import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';

//data
import 'package:tickets/shared/schemas.dart';
import 'package:dartson/dartson.dart';
import "package:intl/intl.dart";

//components
part 'main_tickets_component.dart';
part 'components/landing/landing_component.dart';
part 'components/topnav/topnav_component.dart';

 part 'components/flight_display/flight_display_component.dart';
 part 'components/order/order_component.dart';
 part 'components/order/recap_component.dart';
 part 'components/picker/picker_component.dart';


 part 'services/query_service.dart';
 part 'services/shared_data.dart';
 part 'services/flight_formatter.dart';
part 'services/environment_variables.dart';

 part 'composite_views/view_complete_component.dart';
 part 'composite_views/view_flights_component.dart';
 part 'composite_views/view_order_component.dart';
 part 'composite_views/view_landing_component.dart';


//injectables
const List<Type> client_classes = const [SharedData, FlightQueryService, EnvironmentVariables];