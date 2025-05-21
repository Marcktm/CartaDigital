import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:carta_digital/models/producto.dart';
import 'package:carta_digital/models/producto_repository.dart';

void main() {
  // Necesario para acceder a ServicesBinding.instance en tests
  TestWidgetsFlutterBinding.ensureInitialized();

  late ProductoRepository repo;

  // Simulamos contenido del archivo assets/data/menu.json
  const fakeJson = '''
  [
    {"nombre": "Empanada", "precio": 100, "categoria": "comida"},
    {"nombre": "Coca Cola", "precio": 200, "categoria": "bebida"}
  ]
  ''';

  setUp(() {
    repo = ProductoRepository();

    // Interceptamos la carga de assets y devolvemos el JSON simulado
    ServicesBinding.instance.defaultBinaryMessenger.setMockMessageHandler(
      'flutter/assets',
      (message) async => ByteData.view(
        Uint8List.fromList(fakeJson.codeUnits).buffer,
      ),
    );
  });

  test('cargarDesdeJson devuelve productos correctamente', () async {
    final productos = await repo.cargarDesdeJson();

    expect(productos.length, 2);
    expect(productos[0].nombre, 'Empanada');
    expect(productos[1].categoria, 'bebida');
  });

  test('cargarPorCategoria filtra correctamente', () async {
    final comidas = await repo.cargarPorCategoria('comida');
    final bebidas = await repo.cargarPorCategoria('bebida');

    expect(comidas.length, 1);
    expect(comidas[0].nombre, 'Empanada');

    expect(bebidas.length, 1);
    expect(bebidas[0].nombre, 'Coca Cola');
  });

  test('cargarPorCategoria devuelve vacío si no hay coincidencias', () async {
    final postres = await repo.cargarPorCategoria('postre');
    expect(postres, isEmpty);
  });
}
