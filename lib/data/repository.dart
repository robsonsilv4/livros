import '../models/livros_api_model.dart';
import '../models/result_model.dart';
import 'livro_service.dart';

class Repository {
  final LivrosService livrosService;

  Repository({this.livrosService})
      : assert(
          livrosService != null,
        );

  Future<Result<List<Item>, String>> getBooks(String query) async {
    return livrosService.getBooks(query);
  }
}
