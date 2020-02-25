import 'dart:convert';

import 'package:http/http.dart' as http;

import 'home/bloc/home_page_state.dart';
import 'models.dart';

class Repository {
  final baseUrl = 'https://www.googleapis.com/books/v1/volumes';

  Future<HomePageState> getBooks(String query) async {
    final url = '$baseUrl?q=$query';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final data = LivrosApiModel.fromJson(json);
      final livros = data.items;

      return LoadedState(livros: livros);
    }

    return ErrorState(
      mensagem: 'Ocorreu um erro',
    );
  }
}
