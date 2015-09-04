part of ticket_schemas;

class FlightPostParamsDTO {
  String cityDepart;
  String cityArrival;
  String dateDepart;
  String dateArrival;

  DateTime _dateDepart;
  DateTime _dateArrival;


  FlightPostParamsDTO();

  Map toPostable() {
    var f = new DateFormat('yyyy-MM-dd');
    _dateDepart= DateTime.parse(dateDepart);
    _dateArrival= DateTime.parse(dateDepart);
    return {'cityDepart': cityDepart, 'cityArrival': cityArrival, 'dateDepart': f.format( _dateDepart ) , 'dateArrival': f.format( _dateArrival ) };
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
    instance.dateDepart = aMap['dateDepart'];
    instance.dateArrival = aMap['dateDepart']; //Todo: Jack Murphy to normalize

    instance._dateDepart= DateTime.parse(aMap['dateDepart']);
    instance._dateArrival= DateTime.parse(aMap['dateArrival']);
    return instance;
  }
}