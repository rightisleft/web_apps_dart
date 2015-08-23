import 'dart:html';
import 'dart:async';
import 'package:json_object/json_object.dart';

DocumentFragment _templateFrag;
DivElement _templateSrc;
Element _view;

main() {
  print('This is main.dart from test');
  AnchorElement btn = querySelector('#hw');
  btn.onClick.listen(handleClick);

  // Select target where all deals will be added
  _view = querySelector('#deals');

  //Parse Box Template And Store Locally
  _templateFrag = querySelector('template').content;
  _templateSrc = new Element.div();
  _templateSrc.nodes.addAll(_templateFrag.nodes);

//  render();
}

handleClick(Event e) {
  InputElement input = querySelector('input');
  input.value += e.target.text + " ";
}

void render() async {
  String result = await HttpRequest.getString('deals.json');
  JsonObject response = new JsonObject.fromJsonString(result);
  List dealVOs = response.deals;

  dealVOs.forEach((dealVO) {
      Deal aDeal = new Deal();
      aDeal.city.text = dealVO.city_departure + " to " + dealVO.city_arrival;
      aDeal.date.text = dealVO.date;
      aDeal.price.text = dealVO.price;
      aDeal.description.text = dealVO.description;
      aDeal.image.src = dealVO.image;

      _view.children.add(aDeal.element);
  });
}

class Deal {
  HeadingElement city;
  ParagraphElement description;
  HeadingElement date;
  HeadingElement price;
  ImageElement image;
  AnchorElement button;
  DivElement element;

  Deal() {
    element = _templateSrc.clone(true);
    city = element.querySelector('h3');
    date = element.querySelector('h4');
    price = element.querySelector('h5');
    image = element.querySelector('img');
    button = element.querySelector('a');
    description = element.querySelector('p');

    //dynamically add an Anchor Element
    button = new Element.a();
    button.setAttribute('class', 'btn btn-info');
    button.text = "Buy";
    element.querySelector('.deal-box').children.add(button);
  }
}