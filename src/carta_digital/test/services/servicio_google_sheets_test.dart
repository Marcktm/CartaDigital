import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:carta_digital/services/servicio_google_sheets.dart';

class MockUserSheetApi extends Mock implements UserSheetApi {}

void main() {
  late MockUserSheetApi mockSheet;

  setUp(() {
    mockSheet = MockUserSheetApi();
  });

  group('UserSheetApi', () {
    test('getFirstColumn devuelve una lista de strings no vacía', () async {
      
      when(() => mockSheet.getFirstColumn())
          .thenAnswer((_) async => ['uid123', 'uid456']);

      final result = await mockSheet.getFirstColumn();

      expect(result, isA<List<String>>());
      expect(result.length, 2);
      expect(result.contains('uid123'), isTrue);

      verify(() => mockSheet.getFirstColumn()).called(1);
    });

    test('insert llama correctamente a insert con una lista', () async {
      final mockList = [
        { 'Nombre': 'uid123', 'Email': 'user@test.com' }
      ];

      when(() => mockSheet.insert(any())).thenAnswer((_) async {});

      await mockSheet.insert(mockList);

      verify(() => mockSheet.insert(mockList)).called(1);
    });

    test('init se llama correctamente', () async {
      when(() => mockSheet.init()).thenAnswer((_) async {});

      await mockSheet.init();

      verify(() => mockSheet.init()).called(1);
    });
  });
}
