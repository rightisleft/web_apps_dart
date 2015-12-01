part of ticket_client;

@Component(
    selector: 'view-flights'
)
@View(
    directives: const [FlightDisplay, Picker, Topnav],
    template:
    '''
    <topnav></topnav>
    <picker></picker>
    <flight-display></flight-display>
  '''
)
class ViewFlights {
}
