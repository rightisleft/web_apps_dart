part of ticket_client;

@Component(
    selector: "topnav"
)

@View (
  styles: const ["package:tickets/client/components/topnav/topnav.css"],
  templateUrl: "package:tickets/client/components/topnav/topnav.html",
  directives: const [CORE_DIRECTIVES, routerDirectives]
)

class Topnav{
  List<NavButtonDTO> buttons;
  Router _router;

  Topnav(Router router) {
    _router = router;
    buttons = initbuttons();
    buttons.forEach((NavButtonDTO dto) => dto.isActive = dto.route == "");
    print('--topnav--');
  }

  void go(String url) {
    print('goto: '  + url);
    this._router.navigate(url);
  }

  List<NavButtonDTO> initbuttons() {
    List<NavButtonDTO> buttons = new List<NavButtonDTO>();
    buttons.add( new NavButtonDTO()..route = "/landing"..content="Home");
    buttons.add( new NavButtonDTO()..route = "/flights"..content="Flights" );
    buttons.add( new NavButtonDTO()..route = "/contact"..content="Contact" );
    return buttons;
  }
}

class NavButtonDTO {
  String route;
  String content;
  bool isActive;
}
