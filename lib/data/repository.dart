import 'package:livros/data/livro_service.dart';
import 'package:livros/models/livros_api_model.dart';
import 'package:livros/models/result_model.dart';

class Repository {
  Repository({required this.livrosService});

  final LivrosService livrosService;

  Future<Result<List<Item>, String>> getBooks(String query) {
    return livrosService.getBooks(query);
  }
}
