part of ticket_client;

@Injectable()
class FlightQueryService{
  String BASE;
  Dartson converter = new Dartson.JSON();

  FlightQueryService(){
    String port = (EnvironmentVariables.DART_ENV == 'production') ? '80' : EnvironmentVariables.PORT;
    this.BASE = 'http://' + window.location.hostname + ':' + port + '/tickets/';
  }

  Future postJson(url, data) {
    Completer contract = new Completer();
    HttpRequest request = new HttpRequest(); // create a new XHR
    request.open("POST", url);
    request.onReadyStateChange.listen((_) {
      if (request.readyState == HttpRequest.DONE && (request.status == 200 || request.status == 0)) {
        contract.complete(request.responseText);
      }
    });
    request.send(data); // perform the async POST
    return contract.future;
  }

  Future fetchFlightTimes(FlightFormatter params) async {
    var post = JSON.encode( params.toPostable() );
    return postJson(BASE + 'times', post ).then(handleTimes);
  }
  Future fetchFlightByNumber(String flightId) async {
    return HttpRequest.getString(BASE + 'flight/' + flightId ).then(handleTimes);
  }

  Future fetchCities() async {
    return HttpRequest.getString(BASE + 'cities').then(handleCities);
  }

  Future purchaseTicket(String json) async {
    return postJson(BASE + 'purchase', json).then(handlePurchase);
  }

  List<TimeDTO> handleTimes(String resp) {

    List<TimeDTO> dtos = converter.decode(resp, new TimeDTO(), true);
    return dtos;
  }

  List<RouteDTO> handleRoutes(String response) {
    List<RouteDTO> dtos = converter.decode(response, new RouteDTO(), true);
    return dtos;
  }

  List<CityDTO> handleCities(String response) {
    List<CityDTO> dtos = converter.decode(response, new CityDTO(), true);
    return dtos;
  }

  TransactionDTO handlePurchase(String response) {
    TransactionDTO dtos = converter.decode(response, new TransactionDTO());
    return dtos;
  }
}
