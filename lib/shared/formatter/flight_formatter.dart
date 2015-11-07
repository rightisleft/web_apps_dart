part of ticket_schemas;

class FlightFormatter  {
  String cityDepart;
  String cityArrival;
  String dateDepart;

  DateTime _dateDepart;


  FlightFormatter();

  Map toPostable() {
    var f = new DateFormat('yyyy-MM-dd');
    _dateDepart= DateTime.parse(dateDepart);
    return {'cityDepart': cityDepart, 'cityArrival': cityArrival, 'dateDepart': f.format( _dateDepart ) };
  }

  String format(DateTime value)
  {
    var f = new DateFormat.yMMMMd('en_US');
    return f.format(value);
  }

  factory FlightFormatter.FromPost(Map aMap) {
    FlightFormatter instance = new FlightFormatter();
    instance.setup(aMap, instance);
    return instance;
  }

  FlightFormatter setup(Map aMap, FlightFormatter instance)
  {

    instance.cityArrival = aMap['cityArrival'];
    instance.cityDepart = aMap['cityDepart'];
    instance.dateDepart = aMap['dateDepart'];
    instance._dateDepart= DateTime.parse(aMap['dateDepart']);
    return instance;
  }
}
