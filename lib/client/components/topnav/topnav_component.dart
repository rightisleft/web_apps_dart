part of ticket_client;

@Component(
    selector: "topnav"
)

@View (
    templateUrl: "package:tickets/client/components/topnav/topnav.html",
    encapsulation: ViewEncapsulation.None,
    directives: const [CORE_DIRECTIVES, ROUTER_DIRECTIVES]
)

class Topnav{
  List<NavButtonDTO> buttons;
  Router _router;
  RouteParams params;

  Topnav(Router router, RouteParams this.params) {
    print('-- Topnav Init --');
    _router = router;
    buttons = initbuttons();
  }

  void go(String url) {
    this._router.navigateByUrl(url);
  }

  List<NavButtonDTO> initbuttons() {
    List<NavButtonDTO> buttons = new List<NavButtonDTO>();
    buttons.add( new NavButtonDTO()..route = "/Home"..content="Home");
    buttons.add( new NavButtonDTO()..route = "/Flights"..content="Flights" );
    return buttons;
  }
}

class NavButtonDTO {
  String route;
  String content;
}
