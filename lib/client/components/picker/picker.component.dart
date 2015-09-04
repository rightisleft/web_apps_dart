part of ticket_client;

@Component(
  selector: 'picker',
  properties: const ['depart']
)
@View(
  styleUrls: const ["package:tickets/client/components/picker/picker.css"],
  templateUrl: "package:tickets/client/components/picker/picker.html",
  directives: const [CORE_DIRECTIVES, FORM_DIRECTIVES, routerDirectives]
)
class Picker extends Object {
  Router _router;
  NgForm flightForm;
  FlightPostParamsDTO info = new FlightPostParamsDTO();
  List<CityDTO> cities;
  FlightQueryService queryService;
  String depart_city;

  Picker(Router this._router, FlightQueryService this.queryService) {
    populateCitites();
    populateState();
  }

  void onFind(city) {
    print(info.cityDepart);
    print(info.cityArrival);
    print(info.toPostable());
    onSubmit();
  }

  void populateCitites() {
    queryService.fetchCities().then( (List<CityDTO> dtos) {
      cities = dtos;
      cities.forEach((CityDTO city) => print(city.airportcode));
    });
  }

  void populateState() {
//    info = info.setup(_routeProvider.parameters, info);
  }

  onSubmit()
  {
    Instruction _navigationInstruction = this._router.generate(['/picker', info.toPostable() ]);
    this._router.navigateInstruction(_navigationInstruction);
  }
}