import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livros/data/repository.dart';
import 'package:livros/home/bloc/home_page_event.dart';
import 'package:livros/home/bloc/home_page_state.dart';
import 'package:livros/models/result_model.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc({required this.repository}) : super(HomePageState.initial()) {
    on<SearchEvent>(_onSearchEvent);
  }

  final Repository repository;

  Future<void> _onSearchEvent(
    SearchEvent event,
    Emitter<HomePageState> emit,
  ) async {
    emit(
      state.copyWith(
        categoria: event.categoria,
        livros: Result.loading(),
      ),
    );

    final livros = await repository.getBooks(event.categoria);
    emit(state.copyWith(livros: livros));
  }
}
