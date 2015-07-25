part of ticket_schemas;

@Entity()
class PurchaseDTO extends Object
{
  num flightID;
  num flightLevel;
  num ccn;
  num ccv;
  String ccType;
  String ccExpiration;

  String pFirstName;
  String pMiddleName;
  String pLastName;
  String pEmail;

  String bFirstName;
  String bMiddleName;
  String bLastName;
  String bAddress;
  String bCity;
  String bState;
  num bZip;
  String bCountry;
}
