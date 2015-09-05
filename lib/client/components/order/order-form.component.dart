part of ticket_client;

@Component(
  selector: 'order-form'
)
@View(
  directives: const[FORM_DIRECTIVES],
  styleUrls: const ["package:tickets/client/components/order/order.css"],
  templateUrl: "package:tickets/client/components/order/form.html"
)
class OrderForm extends Object {

  Router _router;
  RouteParams routeParams;
  FlightQueryService queryService;
  TimeDTO timeDTO;
  Recap recap;
  PurchaseDTO dto = new PurchaseDTO();
  NgForm orderForm;
  SharedData shared;

  OrderForm(Router this._router, RouteParams this.routeParams, FlightQueryService this.queryService, SharedData this.shared) {
   fetch();
  }

  Future fetch() async {
    if(routeParams != null && routeParams.params.isEmpty == false)
    {
      List<TimeDTO> dtos = await queryService.fetchFlightByNumber(routeParams.params['id'].toString());
      print(dtos);
      timeDTO = dtos.first;
      dto.flightID = timeDTO.flight;
      dto.flightLevel = int.parse( routeParams.params['level'].toString() );

      shared.purchaseDTO = dto;
      shared.timeDTO = timeDTO;
    }
  }

  Future onSubmit() async  {
    print(orderForm);
    print(dto);
    print('--complete--');
    var dson = new Dartson.JSON();
    String jsonString = dson.encode(dto);
    print(jsonString);
    shared.transaction = await queryService.purchaseTicket(jsonString);
    _router.navigate('/order/complete').then((item) => print(item) );
  }
}