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
    return id.path.indexOf('web/index.html') != -1;
  }

  Future apply(Transform transform) {
    print('IndexTransformer...');
    var input = transform.primaryInput;
    return transform.readInputAsString(input.id).then((string){
      var document = parse(string);
      String port = Platform.environment['PORT'];
      String env = Platform.environment['DART_ENV'];
      String tag = Platform.environment['INDEX_TRANSFORMER_TAG'];
      if(port != null  && tag != null)
      {
        List arr = document.getElementsByTagName(tag);
        if(arr.length > 0)
        {
          print('Found Tickets Element...');
          Element tickets = arr.first;
          tickets.attributes['port'] = port;
          tickets.attributes['environment'] = env;
          print(document.outerHtml);
          transform.addOutput(new Asset.fromString(input.id, document.outerHtml ));
        }
      }
    });
  }
}
