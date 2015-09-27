part of ticket_client;

@Component(
    selector: 'flight-display'
)
@View(
    styleUrls: const ["package:tickets/client/components/flight_display/flight_display.scss"],
    templateUrl: "package:tickets/client/components/flight_display/flight_display.html",
    directives: const[CORE_DIRECTIVES]
)
class FlightDisplay extends Object {

  RouteParams routeParams;
  Router router;
  num service_level;
  FlightQueryService queryService;
  FlightFormatter params;
  List<TimeDTO> flight_times;
  List<RouteDTO> routes;
  TimeDTO selectedDTO;

  FlightDisplay(Router this.router, RouteParams this.routeParams, FlightQueryService this.queryService) {
    if(routeParams.params != null && routeParams.params.isEmpty == false)
    {
      params = new FlightFormatter.FromPost(routeParams.params);
      fetchData(params);
    }
  }

  fetchData(params) {
    queryService.fetchFlightTimes(params).then( (List<TimeDTO> dtos) {
      flight_times = dtos;
    });
  }

  void select(TimeDTO tdto, level) {
    service_level = level;
    selectedDTO = tdto;
  }

  bool isSelected(TimeDTO value) {
    if(selectedDTO != null)
    {
      return selectedDTO.flight == value.flight;
    }
    return false;
  }

  void onsubmit(TimeDTO time)
  {
    var post = params.toPostable();
    post['id'] = time.flight;
    post['level'] = service_level;
    Instruction _navigationInstruction = router.generate(['/order', post]);
    router.navigateInstruction(_navigationInstruction);
  }
}
