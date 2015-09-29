import 'package:barback/barback.dart';
import 'dart:async';
import 'dart:io';
import 'package:html/parser.dart';
import 'package:html/dom.dart';

class IndexTransformer extends Transformer {
  String index;

  IndexTransformer(this.index);

  IndexTransformer.asPlugin();

  Future<bool> isPrimary(AssetId id) async {
    return id.path == 'web/index.html';
  }

  Future apply(Transform transform) {
    print('IndexTransformer...');
    var input = transform.primaryInput;
    return transform.readInputAsString(input.id).then((string){
      var document = parse(string);
      print('start ports');
      String port = Platform.environment['PORT'];
      String env = Platform.environment['DART_ENV'];
      String tag = Platform.environment['INDEX_TRANSFORMER_TAG'];
      if(tag != null)
      {
        List arr = document.getElementsByTagName(tag);
        if(arr.length > 0)
        {
          print('Found Tickets Element...');
          Element tickets = arr.first;
          tickets.attributes['environment'] = env;

          //default to 80 if in production
          tickets.attributes['port'] = (env == 'production') ? '80' : port;

          print(document.outerHtml);
          transform.addOutput(new Asset.fromString(input.id, document.outerHtml ));
        }
      }
    });
  }
}
