import 'package:angular2/angular2.dart';

@Component(
    selector: 'ticket_app'
)
@View(
    template: '<h1>Hello {{ name }}</h1>'
)
class TicketApp {
  String name = 'Jit Ticket Application';
}
