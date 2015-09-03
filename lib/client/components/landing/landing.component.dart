part of ticket_client;

@Component(
  selector: "landing"
)

@View (
  styles: const ["package:tickets/client/components/landing/landing.css"],
  templateUrl: "package:tickets/client/components/landing/landing.html",
  directives: const [CORE_DIRECTIVES]
)

class Landing{
  Router _router;

  Landing(Router router) {
    _router = router;
    print('--topnav--');
  }
}

