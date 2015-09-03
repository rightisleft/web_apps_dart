part of ticket_client;

@Injectable()
class FlightQueryService{
  final String BASE = 'http://localhost:1234/tickets/';
  HttpRequest _http;

  FlightQueryService(HttpRequest this._http) {}

  Future fetchFlightTimes(FlightPostParamsDTO params) async {
    Map post = params.toPostable();
    return _http.post(BASE + 'times', post ).then(handleTimes);
  }

  Future fetchFlightByNumber(num id) async {
    return _http.get(BASE + 'flight/' + id.toString()).then(handleTimes);
  }

  Future fetchCities() async {
    return _http.get(BASE + 'cities').then(handleCities);
  }

  Future purchaseTicket(String json) async {
    return _http.post(BASE + 'purchase', json).then(handlePurchase);
  }

  List<TimeDTO> handleTimes(HttpResponse response) {
    Dartson converter = new Dartson.JSON();
    var string = JSON.encode(response.data);
    List<TimeDTO> dtos = converter.decode(string, new TimeDTO(), true);
    return dtos;
  }

  List<RouteDTO> handleRoutes(HttpResponse response) {
    Dartson converter = new Dartson.JSON();
    var string = JSON.encode(response.data);
    List<RouteDTO> dtos = converter.decode(string, new RouteDTO(), true);
    return dtos;
  }

  List<CityDTO> handleCities(HttpResponse response) {
    Dartson converter = new Dartson.JSON();
    var string = JSON.encode(response.data);
    List<CityDTO> dtos = converter.decode(string, new CityDTO(), true);
    return dtos;
  }

  TransactionDTO handlePurchase(HttpResponse response) {
    Dartson converter = new Dartson.JSON();
    var string = JSON.encode(response.data);
    TransactionDTO dtos = converter.decode(string, new TransactionDTO());
    return dtos;
  }
}



