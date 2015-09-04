part of ticket_client;

@Component(
    selector: 'tickets'
)
@View(
    template: '<topnav></topnav> <h1>Hello {{ name }}</h1> <router-outlet></router-outlet>',
    directives: const [Topnav, RouterOutlet]
)
@RouteConfig(const [
  const Route(path: '/landing', component: Landing, as: 'landing'),
  const Route(path: '/flights', component: FlightDisplay, as: 'flights'),
  const Route(path: '/contact', component: Picker, as: 'contact'),
  const Route(path: '/picker/:cityDepart/:cityArrival/:dateDepart/:dateArrival/', component: FlightDisplay, as: 'picker'),
])
class Tickets {
  String name = 'Jit Ticket Application';
  Router router;

  Tickets(this.router) {
    router.subscribe( (value) {
      print("Route changed to: $value");
    });
  }
}