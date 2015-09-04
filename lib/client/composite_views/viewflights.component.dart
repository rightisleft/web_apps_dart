part of ticket_client;

@Component(
  selector: 'view-flights'
)
@View(
  directives: const [FlightDisplay, Picker],
  template:
  '''
    <h1>Flights</h1>
    <picker></picker>
    <flight-display></flight-display>
  '''
)
class ViewFlights extends Object {
  ViewFlights();
}
