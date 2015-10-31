part of ticket_client;

@Component(
    selector: "landing",
    inputs: const['deals']
)
@View (
    templateUrl: "package:tickets/client/components/landing/landing.html",
    directives: const [CORE_DIRECTIVES]
)

class Landing{
  Router _router;
  List deals;

  Landing(Router this._router) {
    print('-- Landing Init --');
    init();
  }

  Future init() async  {
    String result = await HttpRequest.getString('deals.json');
    var response = JSON.decode(result);
    deals = response['deals'];
  }
}
