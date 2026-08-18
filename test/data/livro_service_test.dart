import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:livros/data/livro_service.dart';
import 'package:livros/models/result_status_model.dart';
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late MockClient client;
  late LivrosService service;

  const baseUrl = 'https://www.googleapis.com/books/v1/volumes';

  setUpAll(() {
    registerFallbackValue(Uri.parse('$baseUrl?q=teste'));
  });

  setUp(() {
    client = MockClient();
    service = LivrosService(client: client);
  });

  test('returns success with books on 200', () async {
    when(() => client.get(Uri.parse('$baseUrl?q=programacao'))).thenAnswer(
      (_) async => http.Response(
        jsonEncode({
          'items': [
            {
              'volumeInfo': {
                'title': 'Clean Code',
                'publisher': 'Prentice Hall',
              },
            },
          ],
        }),
        200,
      ),
    );

    final result = await service.getBooks('programacao');

    expect(result.status, ResultStatus.success);
    expect(result.data, hasLength(1));
    expect(result.data!.first.volumeInfo!.title, 'Clean Code');
  });

  test('returns error on non-200 status', () async {
    when(() => client.get(Uri.parse('$baseUrl?q=programacao'))).thenAnswer(
      (_) async => http.Response('error', 500),
    );

    final result = await service.getBooks('programacao');

    expect(result.status, ResultStatus.error);
    expect(result.error, 'Ocorreu um erro,');
  });

  test('returns error when request throws', () async {
    when(() => client.get(any())).thenThrow(Exception('network'));

    final result = await service.getBooks('programacao');

    expect(result.status, ResultStatus.error);
    expect(result.error, 'Erro desconhecido.');
  });

  test('returns success with empty list when no items', () async {
    when(() => client.get(Uri.parse('$baseUrl?q=matematica'))).thenAnswer(
      (_) async => http.Response(jsonEncode({'totalItems': 0}), 200),
    );

    final result = await service.getBooks('matematica');

    expect(result.status, ResultStatus.success);
    expect(result.data, isEmpty);
  });
}
