import 'package:flutter_test/flutter_test.dart';
import 'package:carta_digital/models/usuario_model.dart';

void main() {
  group('ModeloUsuario', () {
    test('Los valores sean correctos', () {
      expect(ModeloUsuario.correoelectronico, 'Email');
      expect(ModeloUsuario.nombre, 'Nombre');
    });

    test('getDatos devuelve la lista de forma correcta', () {
      expect(ModeloUsuario.getDatos(), ['Email', 'Nombre']);
    });
  });
}
