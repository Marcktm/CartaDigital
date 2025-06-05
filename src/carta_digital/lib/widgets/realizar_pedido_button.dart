import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pedido_provider.dart';

class RealizarPedidoButton extends StatelessWidget {
  const RealizarPedidoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.send),
      label: const Text('Enviar pedido por WhatsApp'),
      onPressed: () async {
        final provider = context.read<PedidoProvider>();
        final exito = await provider.realizarPedido();

        final mensaje = exito
            ? 'Pedido enviado por WhatsApp'
            : 'No se pudo enviar el pedido';

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(mensaje)),
        );
      },
    );
  }
}
