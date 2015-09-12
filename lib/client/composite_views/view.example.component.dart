part of ticket_client;

@Component(
  selector: 'robot',
  properties: const ['strength'],
  events: const['surge']
)
@View(
  directives: const [CORE_DIRECTIVES],
  encapsulation: ViewEncapsulation.NONE,
  template:
  '''
  <h3>Strength: {{ strength }}</h3>
  <div class='robot'>  I am a Robot  </div>
  <a class='btn' (click)='shootRobot()'>Shoot The Robot</a>
  <div template="ng-if 1 + 1 == 2">Your math is good!</div>
  <a href="#" *ng-class="{'.btn': true}">Test</a>
  '''
)
class ExampleComponent {

  Router router;
  Injector injector;
  int strength;
  EventEmitter surge = new EventEmitter();

  ExampleComponent(Injector this.injector) {
    router = injector.get(Router);
  }

  void shootRobot() {
    String msg = 'bullet strike';
    print(msg);
    surge.add(msg);
  }
}

class Alien {
  var color = "green";
}