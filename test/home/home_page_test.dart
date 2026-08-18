import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:livros/home/bloc/home_page_bloc.dart';
import 'package:livros/home/bloc/home_page_event.dart';
import 'package:livros/home/bloc/home_page_state.dart';
import 'package:livros/home/home_page.dart';
import 'package:livros/models/livros_api_model.dart';
import 'package:livros/models/result_model.dart';
import 'package:mocktail/mocktail.dart';

class MockHomePageBloc extends MockBloc<HomePageEvent, HomePageState>
    implements HomePageBloc {}

void main() {
  late MockHomePageBloc bloc;

  setUpAll(() {
    registerFallbackValue(const SearchEvent(categoria: ''));
  });

  setUp(() {
    bloc = MockHomePageBloc();
    whenListen(
      bloc,
      Stream.value(
        HomePageState(
          categoria: '',
          livros: Result.idle(data: const []),
        ),
      ),
      initialState: HomePageState.initial(),
    );
  });

  Widget buildApp() {
    return BlocProvider<HomePageBloc>.value(
      value: bloc,
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }

  testWidgets('renders title and categoria chips', (tester) async {
    await tester.pumpWidget(buildApp());

    expect(find.text('Procurar'), findsOneWidget);
    expect(find.text('Recomendados'), findsOneWidget);
    expect(find.text('Autoajuda'), findsOneWidget);
    expect(find.text('Programacao'), findsOneWidget);
  });

  testWidgets('shows progress indicator while loading', (tester) async {
    whenListen(
      bloc,
      Stream.value(
        HomePageState(
          categoria: 'programacao',
          livros: Result.loading(),
        ),
      ),
      initialState: HomePageState.initial(),
    );

    await tester.pumpWidget(buildApp());
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows error message on error state', (tester) async {
    whenListen(
      bloc,
      Stream.value(
        HomePageState(
          categoria: 'programacao',
          livros: Result.error('Erro desconhecido.'),
        ),
      ),
      initialState: HomePageState.initial(),
    );

    await tester.pumpWidget(buildApp());
    await tester.pump();

    expect(find.text('Erro desconhecido.'), findsOneWidget);
  });

  testWidgets('shows books on success state', (tester) async {
    whenListen(
      bloc,
      Stream.value(
        HomePageState(
          categoria: 'programacao',
          livros: Result.success(const [
            Item(volumeInfo: VolumeInfo(title: 'Clean Code')),
          ]),
        ),
      ),
      initialState: HomePageState.initial(),
    );

    await tester.pumpWidget(buildApp());
    await tester.pump();

    expect(find.text('Clean Code'), findsOneWidget);
  });

  testWidgets('adds SearchEvent when tapping a chip', (tester) async {
    whenListen(
      bloc,
      Stream.value(
        HomePageState(
          categoria: '',
          livros: Result.idle(data: const []),
        ),
      ),
      initialState: HomePageState.initial(),
    );
    when(() => bloc.state).thenReturn(HomePageState.initial());
    when(() => bloc.add(any())).thenReturn(null);

    await tester.pumpWidget(buildApp());
    await tester.tap(find.text('Autoajuda'));

    verify(
      () => bloc.add(const SearchEvent(categoria: 'autoajuda')),
    ).called(1);
  });
}
