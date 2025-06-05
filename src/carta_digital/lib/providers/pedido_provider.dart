import 'package:flutter/material.dart';
import '../models/pedido_model.dart';
import '../models/producto.dart';
import '../models/pedido_service.dart';
import '../models/whatsapp_service.dart';
import '../models/producto_repository.dart';

class PedidoProvider extends ChangeNotifier {
  final PedidoModel _pedido = PedidoModel();
  PedidoModel get pedido => _pedido;

  final ProductoRepository _repo = ProductoRepository();
  List<Producto> _empanadas = [];
  List<Producto> _bebidas = [];
  List<Producto> get empanadas => _empanadas;
  List<Producto> get bebidas => _bebidas;

  Future<void> cargarProductos() async {
    _empanadas = await _repo.cargarPorCategoria('comida');
    _bebidas = await _repo.cargarPorCategoria('bebida');
    notifyListeners();
  }


  void aumentar(Producto producto, int cantidad) {
    _pedido.aumentar(producto, cantidad);
    notifyListeners();
  }

  void disminuir(Producto producto, int cantidad) {
    _pedido.disminuir(producto, cantidad);
    notifyListeners();
  }

  void resetear() {
    _pedido.resetear();
    notifyListeners();
  }

  /// Esta función solo retorna si el envío fue exitoso.
  Future<bool> realizarPedido() async {
    final servicio = PedidoService(_pedido);
    final resumen = servicio.generarResumenTexto();

    try {
      await WhatsAppService.enviarMensaje(resumen);
      resetear(); // resetea solo si salió bien
      return true;
    } catch (_) {
      return false;
    }
  }
}
