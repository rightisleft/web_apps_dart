part of ticket_client;

@Component(
    selector: 'tickets'
)
@View(
    template: '<topnav></topnav><router-outlet></router-outlet>',
    directives: const [Topnav, RouterOutlet]
)
@RouteConfig(const [
  const Route(path: '/landing', component: Landing, as: 'landing'),
  const Route(path: '/flights', component: ViewFlights, as: 'flights'),
  const Route(path: '/contact', component: Picker, as: 'contact'),
  const Route(path: '/picker/:cityDepart/:cityArrival/:dateDepart/:dateArrival/', component: FlightDisplay, as: 'picker'),
  const Route(path: '/order/:id/:level/:dateDepart/:dateArrival/', component: ViewOrder, as: 'order')
//  const Route(path: '/order/success', component: FlightDisplay, as: 'orderSuccess')
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