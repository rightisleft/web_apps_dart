part of ticket_client;

@Component(
    selector: 'flight-display'
)
@View(
  styleUrls: const ["package:tickets/client/components/flight_display/flight_display.css"],
  templateUrl: "package:tickets/client/components/flight_display/flight_display.html"
)
class FlightDisplay extends Object {

  RouteProvider routeProvider;
  Router router;

  NgForm flight_display_form;
  num service_level;

  FlightQueryService queryService;
  FlightPostParamsDTO params;

  List<TimeDTO> flight_times;
  List<RouteDTO> routes;

  FlightDisplay();

//  FlightDisplay(Router this.router, RouteProvider this.routeProvider, FlightQueryService this.queryService) {
//    if(routeProvider.parameters.isEmpty == false)
//    {
//      params = new FlightPostParamsDTO.FromPost(routeProvider.parameters);
//      fetchData(params);
//    }
//  }

  void fetchData(FlightPostParamsDTO params) {
    queryService.fetchFlightTimes(params).then( (List<TimeDTO> dtos) {
      flight_times = dtos;
    });
  }

  void onsubmit(TimeDTO time)
  {
    var post = params.toPostable();
    post['id'] = time.flight;
    post['level'] = service_level;
    router.go('order', post);
  }
}
