part of ticket_client;

@Component(
  selector: "landing",
  properties: const['deals']
)

@View (
  styles: const ["package:tickets/client/components/landing/landing.css"],
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
  String result = await HttpRequest.getString('/web_apps_dart/web/deals.json');
  JsonObject response = new JsonObject.fromJsonString(result);
  deals = response.deals;
  print(deals);
  }

}

