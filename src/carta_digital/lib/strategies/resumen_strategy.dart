import '../models/pedido_model.dart';
import '../services/pedido_service.dart';

/// Interfaz del patrón Strategy para generar resúmenes
abstract class ResumenStrategy {
  String generarResumen(PedidoService servicio);
}

/// Estrategia para mostrar el resumen dentro de la aplicación
class ResumenAppStrategy implements ResumenStrategy {
  const ResumenAppStrategy();

  @override
  String generarResumen(PedidoService servicio) {
    final buffer = StringBuffer();
    final pedido = servicio.pedido;

    pedido.cantidades.forEach((producto, cantidad) {
      buffer.writeln('✔️ ${producto.nombre} ($cantidad)');
    });

    buffer.writeln('\n🧾 Total: \$${servicio.calcularTotal().toStringAsFixed(2)}');
    return buffer.toString();
  }
}

/// Estrategia para generar un resumen estilo comanda de WhatsApp
class ResumenWhatsappStrategy implements ResumenStrategy {
  const ResumenWhatsappStrategy();

  @override
  String generarResumen(PedidoService servicio) {
    final pedido = servicio.pedido;

    if (pedido.cantidades.isEmpty) {
      return "No se han agregado productos.";
    }

    final buffer = StringBuffer();
    pedido.cantidades.forEach((producto, cantidad) {
      final subtotal = producto.precio * cantidad;
      buffer.writeln('${producto.nombre} x$cantidad - \$${subtotal.toStringAsFixed(2)}');
    });

    buffer.writeln('\nTotal: \$${servicio.calcularTotal().toStringAsFixed(2)}');
    return buffer.toString();
  }
}
