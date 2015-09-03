part of ticket_client;

@Component(
  selector: 'searchbox'
)
@View(
  styles: const ["package:tickets/client/components/search/search.css"],
  templateUrl: "package:tickets/client/components/search/search.html"
)
class SearchBox extends Object
{
  SearchBox();
//  SearchBox(RouteProvider routeProvider, FlightQueryService ticketQuery){
////    ticketQuery.fetchRoutes().then( (_) => print('searchbox call is complete') );
//  }
}

//@Genre("techno")
//
//@Decorator(selector: '[tooltip]')
//class Tooltip {
//  final Element element;
//  Tooltip(this.element) {
//    element.text = "Set From Inside";
//  }
//
//  @NgAttr('paco')
//  String paco;
//}



class Genre {
  final String value;
  const Genre(String this.value);
}
