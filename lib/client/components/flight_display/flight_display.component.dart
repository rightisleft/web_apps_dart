part of ticket_client;

@Component(
    selector: 'flight-display',
    properties: const ['emitter']
)
@View(
    styleUrls: const ["package:tickets/client/components/flight_display/flight_display.css"],
    templateUrl: "package:tickets/client/components/flight_display/flight_display.html",
    directives: const[CORE_DIRECTIVES]
//  encapsulation: ViewEncapsulation.NONE // Todo Jack – Google Bug
)
class FlightDisplay extends Object {

  RouteParams routeParams;
  Router router;

  NgForm flight_display_form;
  num service_level;

  FlightQueryService queryService;
  FlightFormatter params;

  List<TimeDTO> flight_times;
  List<RouteDTO> routes;

  EventEmitter external_emitter;

  void set emitter(val) {
    external_emitter = val;
    external_emitter.listen(fetchData);
  }

  EventEmitter get emitter{
    return external_emitter;
  }

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

  void onsubmit(TimeDTO time)
  {
    var post = params.toPostable();
    post['id'] = time.flight;

    post['level'] = service_level;
    Instruction _navigationInstruction = router.generate(['/order', post]);
    router.navigateInstruction(_navigationInstruction);
  }
}
