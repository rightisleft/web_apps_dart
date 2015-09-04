part of ticket_client;

@Injectable()
class FlightQueryService{
  final String BASE = 'http://localhost:5678/tickets/';

  FlightQueryService() {
  }

  Future fetchFlightTimes(FlightPostParamsDTO params) async {
    Map post = params.toPostable();
    return HttpRequest.postFormData(BASE + 'times', post ).then(handleTimes);
  }

  Future fetchFlightByNumber(num id) async {
    return HttpRequest.getString(BASE + 'flight/' + id.toString()).then(handleTimes);
  }

  Future fetchCities() async {
    return HttpRequest.getString(BASE + 'cities').then(handleCities);
  }

  Future purchaseTicket(String json) async {
    return HttpRequest.postFormData(BASE + 'purchase', {}).then(handlePurchase);
  }

  List<TimeDTO> handleTimes(String response) {
    Dartson converter = new Dartson.JSON();
    List<TimeDTO> dtos = converter.decode(response, new TimeDTO(), true);
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



