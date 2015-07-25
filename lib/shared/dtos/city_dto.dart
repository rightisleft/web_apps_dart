part of ticket_schemas;

@Entity()
class CityDTO extends BaseDTO  {
  String collection_key = "Cities";
  String city;
  String airportcode;
  String gate;
}