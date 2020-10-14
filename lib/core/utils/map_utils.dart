import 'package:url_launcher/url_launcher.dart';

class MapUtils {
  static openMap(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not open url';
    }
  }
}
