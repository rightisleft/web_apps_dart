part of ticket_client;

@Component(
    selector: 'tickets'
)
@View(
    template: '<router-outlet></router-outlet>',
    directives: const [RouterOutlet]
)
@RouteConfig(const [
  const Route(path: '/', component: ViewLanding, as: 'home'),
  const Route(path: '/landing', component: ViewLanding, as: 'landing'),
  const Route(path: '/flights', component: ViewFlights, as: 'flights'),
  const Route(path: '/picker/:cityDepart/:cityArrival/:dateDepart/:dateArrival/', component: ViewFlights, as: 'picker'),
  const Route(path: '/order/:id/:level/:dateDepart/:dateArrival/', component: ViewOrder, as: 'order'),
  const Route(path: '/order/complete', component: ViewComplete, as: 'orderComplete')
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