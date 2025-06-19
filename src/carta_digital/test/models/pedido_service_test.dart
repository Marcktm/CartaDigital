import 'package:test/test.dart';
import 'package:carta_digital/models/pedido_model.dart';
import 'package:carta_digital/services/pedido_service.dart';
import 'package:carta_digital/models/producto.dart';

void main() {
  test('calcula correctamente el total', () {
    final pedido = PedidoModel(); // Estado del pedido
    final servicio = PedidoService(pedido); // Lógica

    // Simulamos un pedido de 2 empanadas de $100 cada una
    final producto = Producto(nombre: "Empanada", precio: 100, categoria: "comida", stock: true);
    pedido.aumentar(producto, 2);

    // Verificamos que el total sea 200
    expect(servicio.calcularTotal(), equals(200));
  });

  test('genera correctamente el resumen del pedido', () {
  final pedido = PedidoModel();
  final servicio = PedidoService(pedido);

  final producto = Producto(nombre: "Empanada", precio: 100, categoria: "comida", stock: true);
  pedido.aumentar(producto, 2);

  final resumen = servicio.generarResumenTexto();

  expect(
  resumen,
  'Empanada x2 - \$200.00\n\nTotal: \$200.00\n'
  );
});
}
