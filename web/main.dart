import 'dart:html';
import 'dart:async';
import 'package:json_object/json_object.dart';
import 'package:angular2/bootstrap.dart';
import 'package:tickets/parent_angular.dart';

DocumentFragment _templateFrag;
DivElement _frag;
Element _view;

void main() {
  // Select target where all deals will be added
  _view = querySelector('#deals');

  //Parse Box Template And Store Locally
  _templateFrag = querySelector('template').content;

  render();
  bootstrap(TicketApp);
}


Future render() async {
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
      aDeal.button.href = dealVO.url;

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
    element = new Element.div();
    element.nodes.add( _templateFrag.clone(true) );
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
