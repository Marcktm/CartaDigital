import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import 'package:carta_digital/widgets/randomwidgets.dart';
import 'package:carta_digital/providers/constante_autenticacion.dart';

class MockAuthProvider extends Mock implements AuthProvider {}

void main() {
  group('Chequeo del LoadingOverlay Widget', () {
    testWidgets('muestra CircularProgressIndicator y ModalBarrier cuando isLoading es true', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LoadingOverlay(
            isLoading: true,
            child: const Text('Contenido'),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(ModalBarrier), findsNWidgets(2)); // flutter agrega uno de mas
      expect(find.text('Contenido'), findsOneWidget);
    });

    testWidgets('no muestra CircularProgressIndicator ni ModalBarrier cuando isLoading es false', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LoadingOverlay(
            isLoading: false,
            child: const Text('Contenido'),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(ModalBarrier), findsNWidgets(1)); // Flutter agrega uno siempre 
      expect(find.text('Contenido'), findsOneWidget);
    });
  });

  group('Chequeo del LogoutButton Widget', () {
    late MockAuthProvider mockAuthProvider;

    setUp(() {
      mockAuthProvider = MockAuthProvider();
    });

    testWidgets('muestra ícono y texto "Cerrar sesión"', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<AuthProvider>.value(
            value: mockAuthProvider,
            child: const Scaffold(
              body: LogoutButton(),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.logout), findsOneWidget);
      expect(find.text('Cerrar sesión'), findsOneWidget);
    });

    testWidgets('al presionar llama a signOut y muestra SnackBar', (tester) async {
      when(() => mockAuthProvider.signOut()).thenAnswer((_) async {});

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<AuthProvider>.value(
            value: mockAuthProvider,
            child: const Scaffold(
              body: LogoutButton(),
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.logout)); 
      await tester.pump(); 
      await tester.pump(const Duration(seconds: 1));

      verify(() => mockAuthProvider.signOut()).called(1);
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Sesión cerrada'), findsOneWidget);
    });
  });
}
