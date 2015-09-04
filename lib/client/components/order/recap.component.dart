part of ticket_client;

@Component(
  selector: 'recap'
)
@View(
  styles: const ["package:tickets/client/components/order/recap.css"],
  templateUrl: "package:tickets/client/components/order/recap.html",
  directives: const[CORE_DIRECTIVES]
)
class Recap extends Object {

  Router _router;
  RouteParams _routeParams;
  FlightQueryService queryService;
  FlightPostParamsDTO flightDTO;

  TimeDTO timeDTO;
  SharedData shared;

  Recap(Router this._router, RouteParams this._routeParams, FlightQueryService this.queryService, SharedData this.shared)
  {
    flightDTO = new FlightPostParamsDTO.FromPost(_routeParams.params);
  }

  String format(DateTime value)
  {
    return flightDTO.format(value);
  }

}