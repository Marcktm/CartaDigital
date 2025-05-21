import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pedido_provider.dart';
import 'package:carta_digital/dialogs/resetear_confirmacion.dart';

class ResetearPedidoButton extends StatelessWidget {
  const ResetearPedidoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final confirmado = await mostrarConfirmacionReset(context);

        if (confirmado == true) {
          context.read<PedidoProvider>().resetear();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Pedido reseteado')),
          );
        }
      },
      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
      child: const Text(
        "Resetear Pedido",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
