part of ticket_client;

class FlightFormatter {
  String cityDepart;
  String cityArrival;
  String dateDepart;
  DateTime _dateDepart;

  FlightFormatter();

  factory FlightFormatter.FromPost(Map aMap) {
    FlightFormatter instance = new FlightFormatter();
    instance.cityArrival = aMap['cityArrival'];
    instance.cityDepart = aMap['cityDepart'];
    instance.dateDepart = aMap['dateDepart'];
    instance._dateDepart = DateTime.parse(aMap['dateDepart']);
    return instance;
  }

  Map toPostable() {
    DateFormat dtf = new DateFormat('yyyy-MM-dd');
    _dateDepart = DateTime.parse(dateDepart);
    return {
      'cityDepart': cityDepart,
      'cityArrival': cityArrival,
      'dateDepart': dtf.format(_dateDepart)
    };
  }

  bool isSelected() {
    return ( cityArrival != null && cityDepart != null && dateDepart != null);
  }
}
