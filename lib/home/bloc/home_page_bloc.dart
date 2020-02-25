import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../data/repository.dart';
import '../../models/result_model.dart';
import 'home_page_event.dart';
import 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final Repository repository;

  HomePageState _state = HomePageState.initial();

  HomePageBloc({@required this.repository})
      : assert(
          repository != null,
        );

  @override
  HomePageState get initialState => HomePageState.initial();

  @override
  Stream<HomePageState> mapEventToState(HomePageEvent event) async* {
    if (event is SearchEvent) {
      _state = _state.copy(
        categoria: event.categoria,
        livros: Result.loading(),
      );
      yield _state;

      final query = event.categoria;
      final livros = await repository.getBooks(query);

      _state = _state.copy(livros: livros);
      yield _state;
    }
  }
}
