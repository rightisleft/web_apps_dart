part of ticket_client;

@Component(
  selector: 'view-landing'
)
@View(
  directives: const [Landing, Topnav],
  template:
  '''
    <topnav></topnav>
    <landing></landing>
  '''
)
class ViewLanding {
  ViewLandingViewLanding();
}