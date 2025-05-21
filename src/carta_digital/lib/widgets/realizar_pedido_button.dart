import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pedido_provider.dart';
import '../models/pedido_service.dart';
import '../models/whatsapp_service.dart';
import 'package:carta_digital/dialogs/realizar_confirmacion.dart'; // ✅ nueva importación

class RealizarPedidoButton extends StatelessWidget {
  const RealizarPedidoButton({super.key});

  @override
  Widget build(BuildContext context) {
    final pedido = context.watch<PedidoProvider>().pedido;
    final servicio = PedidoService(pedido);
    final whatsapp = WhatsAppService(numeroDestino: '5493515598947');

    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      onPressed: () async {
        final confirmado = await mostrarConfirmacionRealizar(context); // ✅ confirmación

        if (confirmado == true) {
          final mensaje = servicio.generarResumenTexto();

          try {
            await whatsapp.enviarMensaje(mensaje);
          } catch (_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('No se pudo abrir WhatsApp')),
            );
          }
        }
      },
      icon: const Icon(Icons.send),
      label: const Text("Realizar Pedido"),
    );
  }
}
