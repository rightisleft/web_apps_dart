part of ticket_client;

@Component(
  selector: 'order-form'
)
@View(
  styleUrls: const ["package:tickets/client/components/order/order.css"],
  templateUrl: "package:tickets/client/components/order/form.html"
)
class OrderForm extends Object {

  Router _router;
  RouteProvider _routeProvider;
  FlightQueryService queryService;
  TimeDTO flightDTO;
  Recap recap;
  Scope _scope;
  PurchaseDTO dto= new PurchaseDTO();
  NgForm orderForm;
  SharedData sharedDTO;

  OrderForm();

//  OrderForm(Router this._router, RouteProvider this._routeProvider, FlightQueryService this.queryService, SharedData this.sharedDTO) {
//   fetch();
//  }

  void fetch() {
    if(_routeProvider != null && _routeProvider.parameters.isEmpty == false)
    {
      queryService.fetchFlightByNumber(int.parse(_routeProvider.parameters['id'])).then((List<TimeDTO> dtos){
        flightDTO = dtos.first;
        dto.flightID = flightDTO.flight;
        dto.flightLevel = int.parse(_routeProvider.parameters['level']);
        _scope.rootScope.emit('flight', flightDTO);
      });
    }
  }

  void set scope(Scope scope) {
    // with this scope you should be able to use emit
    // This setter gets called to initialize the scope
    this._scope = scope;
  }

  onSubmit()
  {
    print(orderForm);
    print(dto);
    print('--complete--');
    var dson = new Dartson.JSON();
    String jsonString = dson.encode(dto);
    print(jsonString);
    queryService.purchaseTicket(jsonString).then((TransactionDTO response){
      sharedDTO.transaction = response;
      _router.go('success', {});
    });
  }
}