part of ticket_client;

@Component(
    selector: 'recap'
)
@View(
    styles: const ["package:tickets/client/components/order/recap.scss"],
    templateUrl: "package:tickets/client/components/order/recap.html",
    directives: const[CORE_DIRECTIVES]
)
class Recap extends Object {
  Router _router;
  RouteParams _routeParams;

  FlightFormatter fFlight;
  SharedData shared;

  Recap(Router this._router, RouteParams this._routeParams, SharedData this.shared)
  {
    fFlight = new FlightFormatter.FromPost(_routeParams.params);
  }
}
