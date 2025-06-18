import 'package:flutter/material.dart';
import '../models/pedido_model.dart';
import '../models/producto.dart';
import '../services/pedido_service.dart';
import '../services/whatsapp_service.dart';
import '../models/producto_repository.dart';
import '../strategies/resumen_strategy.dart';



class PedidoProvider extends ChangeNotifier {
  final PedidoModel _pedido = PedidoModel();
  PedidoModel get pedido => _pedido;

  final ProductoRepository _repo = ProductoRepository();
  List<Producto> _empanadas = [];
  List<Producto> _bebidas = [];
  List<Producto> get empanadas => _empanadas;
  List<Producto> get bebidas => _bebidas;

  ResumenStrategy _estrategiaResumen = ResumenWhatsappStrategy();


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

  Future<bool> realizarPedido() async {
  final servicio = PedidoService(_pedido, _estrategiaResumen);
  final resumen = servicio.generarResumenTexto();

  try {
    await WhatsAppService.enviarMensaje(resumen);
    resetear(); // resetea solo si salió bien
    return true;
  } catch (_) {
    return false;
  }
  }

  void cambiarEstrategiaResumen(ResumenStrategy estrategia) {
    _estrategiaResumen = estrategia;
    notifyListeners();
  }

  String obtenerResumen() {
    final servicio = PedidoService(_pedido, _estrategiaResumen);
    return servicio.generarResumenTexto();
  }

  ResumenStrategy get estrategiaResumen => _estrategiaResumen;

}
