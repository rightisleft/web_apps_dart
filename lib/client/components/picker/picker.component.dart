part of ticket_client;

@Component(
    selector: 'picker'
)
@View(
    styleUrls: const ["package:tickets/client/components/picker/picker.css"],
    templateUrl: "package:tickets/client/components/picker/picker.html",
    directives: const [CORE_DIRECTIVES, FORM_DIRECTIVES, ROUTER_DIRECTIVES]
)
class Picker extends Object {
  Router _router;
  RouteParams routeParams;

  NgForm flightForm;
  FlightFormatter info = new FlightFormatter();
  List<CityDTO> cities;
  FlightQueryService queryService;
  String depart_city;

  Picker(Router this._router, FlightQueryService this.queryService,
      RouteParams this.routeParams) {
    populateCitites();
    populateState();
  }

  void onFind(city) {
    onSubmit();
  }

  void populateCitites() {
    queryService.fetchCities().then( (List<CityDTO> dtos) {
      cities = dtos;
    });
  }

  void populateState() {
    if(routeParams.params != null && routeParams.params.isNotEmpty )
    {
      info = info.setup(routeParams.params, info);
    }
  }

  onSubmit()
  {
    Instruction _navInst = this._router.generate(['/picker', info.toPostable() ]);
    this._router.navigateInstruction(_navInst);
  }
}
