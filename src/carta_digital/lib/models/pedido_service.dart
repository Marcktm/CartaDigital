import '../models/pedido_model.dart';
import '../models/producto.dart';

/// Servicio que encapsula la lógica del pedido:
/// cálculo del total, generación de texto para compartir, etc.
class PedidoService {
  final PedidoModel _pedido;

  /// Recibe una instancia de PedidoModel para operar sobre ella
  PedidoService(this._pedido);

  /// Calcula el total del pedido sumando producto.precio * cantidad
  double calcularTotal() {
    return _pedido.cantidades.entries
        .map((e) => e.key.precio * e.value)
        .fold(0.0, (a, b) => a + b);
  }

  /// Genera un resumen del pedido para mostrar o compartir
  String generarResumenTexto() {
    if (_pedido.cantidades.isEmpty) {
      return "No se han agregado productos al pedido.";
    }

    final buffer = StringBuffer();
    _pedido.cantidades.forEach((producto, cantidad) {
      buffer.writeln(
          '${producto.nombre} x$cantidad - \$${(producto.precio * cantidad).toStringAsFixed(2)}');
    });

    buffer.writeln('\nTotal: \$${calcularTotal().toStringAsFixed(2)}');
    return buffer.toString();
  }
  /// Futuro: agregar funciones como aplicar descuento, calcular envío, etc.
}
