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
    buttons.forEach((NavButtonDTO dto) => dto.isActive = dto.route == "");
  }

  void go(String url) {
    this._router.navigate(url);
  }

  List<NavButtonDTO> initbuttons() {
    List<NavButtonDTO> buttons = new List<NavButtonDTO>();
    buttons.add( new NavButtonDTO()..route = "/home"..content="Home");
    buttons.add( new NavButtonDTO()..route = "/flights"..content="Flights" );
    return buttons;
  }
}

class NavButtonDTO {
  String route;
  String content;
  bool isActive;
}
