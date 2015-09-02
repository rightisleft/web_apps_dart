part of ticket_client;

@Component(
    selector: "topnav",
    templateUrl: "packages/angular_dart_demo/client/components/topnav/topnav.html",
    cssUrl: "packages/angular_dart_demo/client/components/topnav/topnav.css",
    useShadowDom: false
)

class Topnav extends Object {
  List<NavButtonDTO> buttons;
  Router _router;

  Topnav(Router router) {
    _router = router;
    buttons = initbuttons();
  }

  List<NavButtonDTO> initbuttons() {
    List<NavButtonDTO> buttons = new List<NavButtonDTO>();
    buttons.add( new NavButtonDTO()..route = "landing"..content="Home");
    buttons.add( new NavButtonDTO()..route = "picker"..content="Flights" );
    buttons.add( new NavButtonDTO()..route = "contact"..content="Contact" );
    return buttons;
  }
}

class NavButtonDTO {
  String route;
  String content;
  bool isActive;
}
