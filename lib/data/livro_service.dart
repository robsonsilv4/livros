import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/livros_api_model.dart';
import '../models/result_model.dart';

class LivrosService {
  final String baseUrl = "https://www.googleapis.com/books/v1/volumes";

  Future<Result<List<Item>, String>> getBooks(String query) async {
    try {
      final url = "$baseUrl?q=$query";
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print(json);
        final data = LivrosApiModel.fromJson(json);
        final livros = data.items;

        return Result.success(livros);
      }

      return Result.error('Ocorreu um erro,');
    } catch (error) {
      print(error.toString());
      return Result.error('Erro desconhecido.');
    }
  }
}
