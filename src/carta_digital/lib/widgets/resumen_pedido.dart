import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pedido_provider.dart';
import '../models/pedido_service.dart';
import 'package:carta_digital/widgets/realizar_pedido_button.dart';
import 'package:carta_digital/widgets/resetear_pedido_button.dart';


class ResumenPedido extends StatelessWidget {
  const ResumenPedido({super.key});

  @override
  Widget build(BuildContext context) {
    final pedido = context.watch<PedidoProvider>().pedido;
    final servicio = PedidoService(pedido);

    return botonesFinal(servicio);
  }

  Widget botonesFinal(PedidoService servicio) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Total: \$${servicio.calcularTotal().toStringAsFixed(2)}",
        style: const TextStyle(fontSize: 20),
      ),
      const SizedBox(height: 10),
      const ResetearPedidoButton(),
      const SizedBox(height: 10),
      const RealizarPedidoButton(),
    ],
  );
}
}