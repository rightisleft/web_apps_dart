part of ticket_schemas;

@Entity()
class RouteDTO extends BaseDTO {
  String collection_key = "Routes";

  String route;
  num duration;
  double price1;
  double price2;
  double price3;
  int seats;

  String getDepartureCity() {
    return route.split('_')[0];
  }

  String getArrivalCity() {
    return route.split('_')[1];
  }
}
