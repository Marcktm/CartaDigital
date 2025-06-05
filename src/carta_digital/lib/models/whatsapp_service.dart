import 'package:url_launcher/url_launcher.dart';

class WhatsAppService {
  static const String _numeroDestino = '5493515598947';

  static Future<bool> enviarMensaje(String mensaje) async {
    final url = Uri.parse("https://wa.me/$_numeroDestino?text=${Uri.encodeComponent(mensaje)}");

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
      return true;
    } else {
      return false;
    }
  }
}
