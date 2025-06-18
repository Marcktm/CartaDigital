import 'package:flutter_test/flutter_test.dart';
import 'package:carta_digital/models/pedido_model.dart';
import 'package:carta_digital/models/producto.dart';

void main() {
  final producto = Producto(nombre: 'Agua', precio: 100, categoria: 'bebida', stock: true);

  test('agrega correctamente un producto', () {
    final pedido = PedidoModel();
    pedido.aumentar(producto, 2);
    expect(pedido.cantidades[producto], equals(2));
  });

  test('disminuye cantidad de un producto', () {
    final pedido = PedidoModel();
    pedido.aumentar(producto, 3);
    pedido.disminuir(producto, 1);
    expect(pedido.cantidades[producto], equals(2));
  });

  test('elimina el producto si la cantidad llega a 0', () {
    final pedido = PedidoModel();
    pedido.aumentar(producto, 1);
    pedido.disminuir(producto, 1);
    expect(pedido.cantidades.containsKey(producto), isFalse);
  });

  test('resetear vacía todos los productos', () {
    final pedido = PedidoModel();
    pedido.aumentar(producto, 5);
    pedido.resetear();
    expect(pedido.cantidades.isEmpty, isTrue);
  });

  test('el mapa de cantidades es inmodificable desde fuera', () {
    final pedido = PedidoModel();
    pedido.aumentar(producto, 1);
    expect(() => pedido.cantidades[producto] = 5, throwsUnsupportedError);
  });
}
