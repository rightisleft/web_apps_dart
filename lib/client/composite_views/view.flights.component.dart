part of ticket_client;

@Component(
  selector: 'view-flights'
)
@View(
  directives: const [FlightDisplay, Picker, Topnav],
  template:
  '''
    <topnav></topnav>
    <picker [emitter]="emt"></picker>
    <flight-display [emitter]="emt"></flight-display>
  '''
)
class ViewFlights extends Object {
  Map item = {'name': 'Jack'};
  EventEmitter emt = new EventEmitter();
  ViewFlights();
}
