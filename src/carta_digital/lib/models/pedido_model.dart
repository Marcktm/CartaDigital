import 'producto.dart';

/// Modelo de datos que representa un pedido realizado por el usuario.
/// Almacena productos seleccionados junto con sus cantidades.
class PedidoModel {
  // Mapa privado que guarda los productos seleccionados y su cantidad
  final Map<Producto, int> _cantidades;

  // Constructor: permite iniciar con un mapa preexistente o vacío
  PedidoModel({Map<Producto, int>? inicial})
      : _cantidades = inicial ?? {};

  /// Aumenta la cantidad de un producto específico en el pedido.
  void aumentar(Producto producto, int cantidad) {
    _cantidades.update(producto, (valor) => valor + cantidad,
        ifAbsent: () => cantidad);
  }

  /// Disminuye la cantidad del producto. Si llega a 0 o menos, lo elimina.
  void disminuir(Producto producto, int cantidad) {
    if (!_cantidades.containsKey(producto)) return;

    final nuevoValor = _cantidades[producto]! - cantidad;

    if (nuevoValor <= 0) {
      _cantidades.remove(producto);
    } else {
      _cantidades[producto] = nuevoValor;
    }
  }

  /// Limpia todo el pedido.
  void resetear() => _cantidades.clear();

  /// Devuelve una copia del mapa de productos con sus cantidades.
  Map<Producto, int> get cantidades => Map.unmodifiable(_cantidades);
}
