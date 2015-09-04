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
  '''
)
class ViewFlights extends Object {
  ViewFlights();
}
