part of ticket_client;

@Component(
  selector: 'recap'
)
@View(
  styles: const ["package:tickets/client/components/order/recap.css"],
  templateUrl: "package:tickets/client/components/order/recap.html"
)
class Recap extends Object {

  Router _router;
  RouteProvider _routeProvider;
  FlightQueryService queryService;
  Scope _scope;
  FlightPostParamsDTO params;

  @NgTwoWay('timeDTO')
  TimeDTO timeDTO;

  Recap();
//  Recap(Router this._router, RouteProvider this._routeProvider, FlightQueryService this.queryService)
//  {
//    params = new FlightPostParamsDTO.FromPost(_routeProvider.parameters);
//  }

  void set scope(Scope scope) {
    // with this scope you should be able to use emit
    // This setter gets called to initialize the scope
    this._scope = scope;
    Stream mystream = _scope.rootScope.on('flight');
    mystream.listen((event){
      timeDTO = event.data;
    });
  }

  String format(DateTime value)
  {
    return params.format(value);
  }

}