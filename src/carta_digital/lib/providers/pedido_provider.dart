import 'package:flutter/material.dart';
import '../models/producto.dart';

class PedidoProvider extends ChangeNotifier {
  final Map<Producto, int> _cantidades = {};

  void aumentar(Producto producto, int cantidad) {
    _cantidades.update(producto, (value) => value + cantidad, ifAbsent: () => cantidad);
    notifyListeners();
  }

  void disminuir(Producto producto, int cantidad) {
    if (!_cantidades.containsKey(producto)) return;
    final nuevoValor = _cantidades[producto]! - cantidad;
    if (nuevoValor <= 0) {
      _cantidades.remove(producto);
    } else {
      _cantidades[producto] = nuevoValor;
    }
    notifyListeners();
  }

  Map<Producto, int> get cantidades => _cantidades;

  double get total {
    return _cantidades.entries
        .map((e) => e.key.precio * e.value)
        .fold(0.0, (a, b) => a + b);
  }

  void resetear() {
    _cantidades.clear();
    notifyListeners();
  }
}
