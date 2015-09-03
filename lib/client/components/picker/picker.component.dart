part of ticket_client;

@Component(
  selector: 'picker'
)
@View(
  styles: const ["package:tickets/client/components/picker/picker.css"],
  templateUrl: "package:tickets/client/components/picker/picker.html"
)
class Picker extends Object {

  Router _router;
  RouteProvider _routeProvider;
  NgForm flightForm;
  FlightPostParamsDTO info = new FlightPostParamsDTO();
  List<CityDTO> cities;
  FlightQueryService queryService;

  Picker();

//  Picker(Router this._router, RouteProvider this._routeProvider, FlightQueryService this.queryService) {
//    populateCitites();
//    populateState();
//  }

  void populateCitites() {
    queryService.fetchCities().then( (List<CityDTO> dtos) {
      cities = dtos;
    });
  }

  void populateState() {
    if(_routeProvider.parameters.isEmpty == false)
    {
      info = info.setup(_routeProvider.parameters, info);
    }
  }

  onSubmit(NgForm form)
  {
    print(form);
    var postItem =  info.toPostable();
    this._router.go('flightsId', postItem );
  }
}