import 'package:url_launcher/url_launcher.dart';

Future<void> makeCall(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
      );
    } else {}
  }
