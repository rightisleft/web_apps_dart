part of ticket_schemas;

@Entity()
class BookingDTO extends BaseDTO
{
  String collection_key = "Bookings";

  String firstname;
  String lastname;
  String email;
  int phone;
  String address;
  String flight;
  String transaction;
}
