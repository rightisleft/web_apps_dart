part of ticket_client;

@Component(
    selector: "topnav"
)

@View (
  styles: const ["package:tickets/client/components/topnav/topnav.css"],
  templateUrl: "package:tickets/client/components/topnav/topnav.html",
  directives: const [CORE_DIRECTIVES, ROUTER_DIRECTIVES]
)

class Topnav{
  List<NavButtonDTO> buttons;
  Router _router;
  RouteParams params;

  Topnav(Router router, RouteParams this.params) {
    _router = router;
    buttons = initbuttons();
    buttons.forEach((NavButtonDTO dto) => dto.isActive = dto.route == "");
  }

  void go(String url) {
    this._router.navigate(url);
  }

  List<NavButtonDTO> initbuttons() {
    List<NavButtonDTO> buttons = new List<NavButtonDTO>();
    buttons.add( new NavButtonDTO()..route = "/landing"..content="Home");
    buttons.add( new NavButtonDTO()..route = "/flights"..content="Flights" );
    return buttons;
  }
}

class NavButtonDTO {
  String route;
  String content;
  bool isActive;
}
