import 'package:flutter_test/flutter_test.dart';
import 'package:carta_digital/models/producto.dart';
import 'package:carta_digital/models/producto_repository.dart';

class ProductoRepositoryFake extends ProductoRepository {
  @override
  Future<List<Producto>> cargarDesdeGoogleSheets() async {
    const fakeSheetData = [
      ["nombre", "precio", "categoria", "stock"],
      ["Empanada", "100", "comida", "si"],
      ["Coca Cola", "200", "bebida", "no"],
      ["Agua", "150", "bebida", "si"],
    ];

    final rows = fakeSheetData.skip(1); // omitir cabecera
    return rows
        .map((row) => Producto(
              nombre: row[0],
              precio: double.tryParse(row[1]) ?? 0,
              categoria: row[2],
              stock: row[3].toLowerCase() == 'si',
            ))
        .where((p) => p.stock)
        .toList();
  }
}

void main() {
  late ProductoRepository repo;

  setUp(() {
    repo = ProductoRepositoryFake();
  });

  test('Filtra productos con stock desde fakeSheetData', () async {
    final productos = await repo.cargarDesdeGoogleSheets();

    expect(productos.length, 2);
    expect(productos.any((p) => p.nombre == 'Coca Cola'), isFalse);
    expect(productos.any((p) => p.nombre == 'Agua'), isTrue);
  });

  test('Filtra productos por categoría', () async {
    final comidas = await repo.cargarPorCategoria('comida');
    final bebidas = await repo.cargarPorCategoria('bebida');

    expect(comidas.length, 1);
    expect(comidas[0].nombre, 'Empanada');

    expect(bebidas.length, 1);
    expect(bebidas[0].nombre, 'Agua');
  });
}
