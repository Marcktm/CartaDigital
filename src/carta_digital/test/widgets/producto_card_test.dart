import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:carta_digital/models/producto.dart';
import 'package:carta_digital/providers/pedido_provider.dart';
import 'package:carta_digital/widgets/producto_card.dart';

void main() {
  testWidgets('ProductoCard muestra nombre y precio', (WidgetTester tester) async {
    // Arrange: Crear producto de prueba
    final producto = Producto(
      nombre: 'Empanada',
      precio: 100, // 👈 Se espera que se muestre como "$100"
      categoria: 'comida',
      stock: true
    );

    // Act: Montar el widget con Provider, MaterialApp y Scaffold
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => PedidoProvider(),
        child: MaterialApp(
          home: Scaffold(
            body: ProductoCard(producto: producto),
          ),
        ),
      ),
    );

    // Assert: Verificar que el contenido aparece correctamente
    expect(find.text('Empanada'), findsOneWidget);           // Nombre
    expect(find.textContaining('Precio: \$100'), findsOneWidget);      // Precio formateado
    expect(find.byIcon(Icons.add), findsOneWidget);          // Botón +
    expect(find.byIcon(Icons.remove), findsOneWidget);       // Botón -
    expect(find.text('0'), findsOneWidget);                  // Cantidad inicial
  });
}
