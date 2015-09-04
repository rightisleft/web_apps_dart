part of ticket_client;

@Injectable()
class FlightQueryService{
  final String BASE = 'http://localhost:5678/tickets/';

  FlightQueryService() {
  }

  Future fetchFlightTimes(FlightPostParamsDTO params) async {
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
    return postJson(BASE + 'purchase', {}).then(handlePurchase);
  }

  List<TimeDTO> handleTimes(String resp) {
    Dartson converter = new Dartson.JSON();
    List<TimeDTO> dtos = converter.decode(resp, new TimeDTO(), true);
    return dtos;
  }

  List<RouteDTO> handleRoutes(String response) {
    Dartson converter = new Dartson.JSON();
    List<RouteDTO> dtos = converter.decode(response, new RouteDTO(), true);
    return dtos;
  }

  List<CityDTO> handleCities(String response) {
    Dartson converter = new Dartson.JSON();
    List<CityDTO> dtos = converter.decode(response, new CityDTO(), true);
    return dtos;
  }

  TransactionDTO handlePurchase(HttpRequest response) {
    Dartson converter = new Dartson.JSON();
    TransactionDTO dtos = converter.decode(response, new TransactionDTO());
    return dtos;
  }
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



