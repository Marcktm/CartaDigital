import '../models/pedido_model.dart';
import '../strategies/precio_strategy.dart';

enum TipoProducto { comida, bebida }

class PedidoService {
  final PedidoModel _pedido;

  PedidoService(this._pedido);

  /// 👇 Esta función encapsula el cálculo por producto con Strategy
  double _calcularSubtotal(producto, cantidad) {
    if (producto.categoria == "comida") {
      PrecioStrategy estrategia;

      if (cantidad >= 12) {
        estrategia = PrecioPorDocena();
      } else if (cantidad >= 6) {
        estrategia = PrecioPorMediaDocena();
      } else {
        estrategia = PrecioIndividual();
      }

      return estrategia.calcularPrecio(cantidad, producto.precio);
    } else {
      return cantidad * producto.precio;
    }
  }

  /// Cálculo total: suma todos los subtotales
  double calcularTotal() {
    return _pedido.cantidades.entries
        .map((e) => _calcularSubtotal(e.key, e.value))
        .fold(0.0, (a, b) => a + b);
  }

  /// Genera un resumen usando la misma lógica
  String generarResumenTexto() {
    if (_pedido.cantidades.isEmpty) {
      return "No se han agregado productos al pedido.";
    }

    final buffer = StringBuffer();
    _pedido.cantidades.forEach((producto, cantidad) {
      final subtotal = _calcularSubtotal(producto, cantidad);
      buffer.writeln('${producto.nombre} x$cantidad - \$${subtotal.toStringAsFixed(2)}');
    });

    buffer.writeln('\nTotal: \$${calcularTotal().toStringAsFixed(2)}');
    return buffer.toString();
  }
}
