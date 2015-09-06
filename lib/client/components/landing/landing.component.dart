part of ticket_client;

@Component(
  selector: "landing",
  properties: const['deals']
)

@View (
  styleUrls: const ["package:tickets/client/components/landing/landing.css"],
  templateUrl: "package:tickets/client/components/landing/landing.html",
  directives: const [CORE_DIRECTIVES]
)

class Landing{
  Router _router;
  List deals;


  Landing(Router this._router) {
    init();
  }

  Future init() async  {
  String result = await HttpRequest.getString('deals.json');
    var response = JSON.decode(result);
    deals = response['deals'];
  }
}
