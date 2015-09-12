part of ticket_client;

@Component(
  selector: 'view-complete'
)
@View(
  directives: const [ROUTER_DIRECTIVES, Topnav],
  template:
  '''
    <topnav></topnav>
    <div class="alert alert-success" role="alert" style="margin: 30px auto; width: 33%;">
        <strong>Well done!</strong>
        You're ticket has been purchased!
    </div>
    <div style="text-align: center;">
        <a [router-link]="['/landing']" class="btn btn-warning">Return Home</a>
    </div>
  '''
)
class ViewComplete {
  ViewComplete();
}