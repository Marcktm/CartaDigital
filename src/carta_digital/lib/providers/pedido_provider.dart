import 'package:flutter/material.dart';
import '../models/producto.dart';
import '../models/pedido_model.dart';

/// Provider que expone el estado del pedido a la UI y
/// notifica cuando hay cambios (agregar, quitar, resetear).
class PedidoProvider extends ChangeNotifier {
  final PedidoModel _pedido = PedidoModel();

  /// Accede al estado actual del pedido.
  PedidoModel get pedido => _pedido;

  /// Aumenta la cantidad de un producto.
  void aumentar(Producto producto, int cantidad) {
    _pedido.aumentar(producto, cantidad);
    notifyListeners(); // Notifica a los widgets para redibujar.
  }

  /// Disminuye la cantidad o elimina si llega a cero.
  void disminuir(Producto producto, int cantidad) {
    _pedido.disminuir(producto, cantidad);
    notifyListeners();
  }

  /// Borra completamente el pedido.
  void resetear() {
    _pedido.resetear();
    notifyListeners();
  }
}
