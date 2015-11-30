part of ticket_client;

@Component(
    selector: 'tickets'
)
@View(
    template: '<router-outlet></router-outlet>',
    directives: const [RouterOutlet]
)
@RouteConfig(const [
  const Route(path: '/', component: ViewLanding, as: 'Home'),
  const Route(path: '/landing', component: ViewLanding, as: 'Landing'),
  const Route(path: '/flights', component: ViewFlights, as: 'Flights'),
  const Route(path: '/picker/:cityDepart/:cityArrival/:dateDepart/', component: ViewFlights, as: 'Picker'),
  const Route(path: '/order/:id/:level/:dateDepart/', component: ViewOrder, as: 'Order'),
  const Route(path: '/order/complete', component: ViewComplete, as: 'OrderComplete')
])
class Tickets {
  String name = 'Jit Ticket Application';
  Router router;

  Tickets(Router this.router) {
    print('-- Tickets Init --');
    router.subscribe( (value) {
      print("Route changed to: $value");
    });
  }
}