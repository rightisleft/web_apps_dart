part of ticket_schemas;

@Entity()
class TransactionDTO extends BaseDTO {
  String collection_key = "Transactions";
  int paid;
  String user;
}
