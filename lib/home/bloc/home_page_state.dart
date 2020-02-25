import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/livros_api_model.dart';
import '../../models/result_model.dart';

class HomePageState extends Equatable {
  final String categoria;
  final Result<List<Item>, String> livros;

  HomePageState({
    @required this.categoria,
    @required this.livros,
  });

  factory HomePageState.initial() {
    return HomePageState(
      categoria: '',
      livros: Result.idle(data: []),
    );
  }

  HomePageState copy({
    String categoria,
    Result<List<Item>, String> livros,
  }) {
    return HomePageState(
      categoria: categoria ?? this.categoria,
      livros: livros ?? this.livros,
    );
  }

  @override
  List<Object> get props => [
        categoria,
        livros,
      ];
}
