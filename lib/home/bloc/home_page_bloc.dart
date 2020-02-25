import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../repository.dart';
import 'home_page_event.dart';
import 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final Repository repository;

  HomePageBloc({@required this.repository});

  @override
  HomePageState get initialState => LoadingState();

  @override
  Stream<HomePageState> mapEventToState(HomePageEvent event) async* {
    if (event is SearchEvent) {
      yield LoadingState();

      final query = event.query;
      final livros = await repository.getBooks(query);

      yield livros;
    }
  }
}
