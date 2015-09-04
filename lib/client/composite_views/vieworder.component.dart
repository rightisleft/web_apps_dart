part of ticket_client;

@Component(
  selector: 'view-order'
)
@View(
  directives: const [OrderForm, Recap],
  template:
  '''
    <recap></recap>
    <order-form></order-form>
  '''
)
class ViewOrder extends Object {
  ViewOrder();
}
