import '../models/pedido_model.dart';
import '../strategies/precio_strategy.dart';
import '../strategies/resumen_strategy.dart';
import '../models/producto.dart';

enum TipoProducto { comida, bebida }

class PedidoService {
  final PedidoModel _pedido;
  ResumenStrategy _estrategiaResumen;

  PedidoService(this._pedido, [this._estrategiaResumen = const ResumenWhatsappStrategy()]);

  PedidoModel get pedido => _pedido;

  /// 👇 Esta función encapsula el cálculo por producto con Strategy
  double _calcularSubtotal(Producto producto, int cantidad) {
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

  /// Setter para cambiar la estrategia en tiempo de ejecución
  void set estrategiaResumen(ResumenStrategy estrategia) {
    _estrategiaResumen = estrategia;
  }

  /// Genera un resumen usando la estrategia actual
  String generarResumenTexto() {
    if (_estrategiaResumen == null) {
      throw Exception('No se ha definido una estrategia para generar el resumen');
    }
    return _estrategiaResumen.generarResumen(this);
  }
}
