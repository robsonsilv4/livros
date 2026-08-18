import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:livros/models/livros_api_model.dart';
import 'package:livros/models/result_model.dart';

class LivrosService {
  LivrosService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;
  static const String _baseUrl = 'https://www.googleapis.com/books/v1/volumes';

  Future<Result<List<Item>, String>> getBooks(String query) async {
    try {
      final url = Uri.parse('$_baseUrl?q=$query');
      final response = await _client.get(url);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final data = LivrosApiModel.fromJson(json);
        final livros = data.items ?? const [];

        return Result.success(livros);
      }

      return Result.error('Ocorreu um erro,');
    } on Exception {
      return Result.error('Erro desconhecido.');
    }
  }
}
