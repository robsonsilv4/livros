import 'package:equatable/equatable.dart';

import 'package:livros/models/livros_api_model.dart';
import 'package:livros/models/result_model.dart';

class HomePageState extends Equatable {
  const HomePageState({
    required this.categoria,
    required this.livros,
  });

  factory HomePageState.initial() {
    return HomePageState(
      categoria: '',
      livros: Result.idle(data: const []),
    );
  }

  final String categoria;
  final Result<List<Item>, String> livros;

  HomePageState copyWith({
    String? categoria,
    Result<List<Item>, String>? livros,
  }) {
    return HomePageState(
      categoria: categoria ?? this.categoria,
      livros: livros ?? this.livros,
    );
  }

  @override
  List<Object?> get props => [categoria, livros];
}
