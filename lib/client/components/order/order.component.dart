part of ticket_client;

@Component(
    selector: 'order-form'
)
@View(
    directives: const[FORM_DIRECTIVES],
    styleUrls: const ["package:tickets/client/components/order/order.scss"],
    templateUrl: "package:tickets/client/components/order/order.html"
)
class OrderForm extends Object {

  Router _router;
  RouteParams _routeParams;
  FlightQueryService _queryService;
  TimeDTO timeDTO;
  SharedData _shared;
  PurchaseDTO dto;

  OrderForm(Router this._router, RouteParams this._routeParams, FlightQueryService this._queryService, SharedData this._shared) {
    fetch();
  }

  Future fetch() async {
    if(_routeParams != null && _routeParams.params.isEmpty == false)
    {
      List<TimeDTO> dtos = await _queryService.fetchFlightByNumber(_routeParams.params['id'].toString());
      timeDTO = dtos.first;

      dto = new PurchaseDTO();
      dto.flightID = timeDTO.flight;
      dto.flightLevel = int.parse( _routeParams.params['level'].toString() );

      _shared.purchaseDTO = dto;
      _shared.timeDTO = timeDTO;
    }
  }

  Future onSubmit() async  {
    var dson = new Dartson.JSON();
    String jsonString = dson.encode(dto);
    _shared.transaction = await _queryService.purchaseTicket(jsonString);
    _router.navigate('/order/complete').then((item) => print(item) );
  }
}
