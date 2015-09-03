part of ticket_schemas;

class FlightPostParamsDTO {
  String cityDepart;
  String cityArrival;
  DateTime dateDepart;
  DateTime dateArrival;

  FlightPostParamsDTO();

  Map toPostable() {
    var f = new DateFormat('yyyy-MM-dd');
    return {'cityDepart': cityDepart, 'cityArrival': cityArrival, 'dateDepart': f.format( dateDepart ) , 'dateArrival': f.format( dateArrival ) };
  }

  String format(DateTime value)
  {
    var f = new DateFormat.yMMMMd('en_US');
    return f.format(value);
  }

  factory FlightPostParamsDTO.FromPost(Map aMap) {
    FlightPostParamsDTO instance = new FlightPostParamsDTO();
    instance.setup(aMap, instance);
    return instance;
  }

  FlightPostParamsDTO setup(Map aMap, FlightPostParamsDTO instance)
  {
    instance.cityArrival = aMap['cityArrival'];
    instance.cityDepart = aMap['cityDepart'];
    instance.dateDepart= DateTime.parse(aMap['dateDepart']);
    instance.dateArrival= DateTime.parse(aMap['dateArrival']);
    return instance;
  }
}