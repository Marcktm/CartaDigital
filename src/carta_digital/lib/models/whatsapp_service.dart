import 'package:url_launcher/url_launcher.dart';

class WhatsAppService {
  final String numeroDestino;

  WhatsAppService({required this.numeroDestino});

  Future<void> enviarMensaje(String mensaje) async {
    final url = Uri.parse("https://wa.me/$numeroDestino?text=${Uri.encodeComponent(mensaje)}");

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw Exception('No se pudo abrir WhatsApp');
    }
  }
}
