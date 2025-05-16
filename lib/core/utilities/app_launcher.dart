import 'package:url_launcher/url_launcher.dart';
//https://flutter.dev
//mailto:smith@example.org
//tel:+1-555-010-999


Future<void> appLaunchUrl(
    {required String url}) async {
  final urlParse = Uri.parse(url);

  if (await canLaunchUrl(urlParse)) {
    await launchUrl(urlParse, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $urlParse';
  }
}
