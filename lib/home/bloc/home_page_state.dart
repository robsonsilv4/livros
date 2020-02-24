import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models.dart';

class HomePageState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingState extends HomePageState {}

class LoadedState extends HomePageState {
  final List<Book> livros;

  LoadedState({@required this.livros});
}

class ErrorState extends HomePageState {
  final String mensagem;

  ErrorState({@required this.mensagem});
}
