import 'package:flutter_test/flutter_test.dart';
import 'package:carta_digital/models/producto.dart';
import 'package:carta_digital/providers/pedido_provider.dart';

void main() {
  test('aumentar agrega el producto correctamente', () {
    final provider = PedidoProvider();
    final producto = Producto(nombre: 'Empanada', precio: 100, categoria: 'comida');

    provider.aumentar(producto, 1);

    expect(provider.pedido.cantidades[producto], 1);
  });

  test('disminuir reduce la cantidad correctamente', () {
    final provider = PedidoProvider();
    final producto = Producto(nombre: 'Empanada', precio: 100, categoria: 'comida');

    provider.aumentar(producto, 2);
    provider.disminuir(producto, 1);

    expect(provider.pedido.cantidades[producto], 1);
  });

  test('resetear borra todos los productos', () {
    final provider = PedidoProvider();
    final producto = Producto(nombre: 'Empanada', precio: 100, categoria: 'comida');

    provider.aumentar(producto, 3);
    provider.resetear();

    expect(provider.pedido.cantidades.isEmpty, true);
  });
}
