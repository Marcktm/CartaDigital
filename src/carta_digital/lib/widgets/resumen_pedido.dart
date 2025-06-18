import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pedido_provider.dart';
import '../services/pedido_service.dart';
import 'package:carta_digital/widgets/realizar_pedido_button.dart';
import 'package:carta_digital/widgets/resetear_pedido_button.dart';

class ResumenPedido extends StatelessWidget {
  const ResumenPedido({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PedidoProvider>();
    final pedido = provider.pedido;
    final estrategia = provider.estrategiaResumen;
    final servicio = PedidoService(pedido, estrategia);

    return botonesFinal(servicio);
  }

  Widget botonesFinal(PedidoService servicio) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ✅ Texto generado por la estrategia
        Text(
          servicio.generarResumenTexto(),
          style: const TextStyle(
            fontSize: 16,
            fontFamily: 'monospace', // opcional, para estilo tipo ticket/comanda
          ),
        ),
        const SizedBox(height: 10),
        const ResetearPedidoButton(),
        const SizedBox(height: 10),
        const RealizarPedidoButton(),
      ],
    );
  }
}
