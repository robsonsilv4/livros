import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:livros/data/livro_service.dart';
import 'package:livros/data/repository.dart';
import 'package:livros/home/bloc/home_page_bloc.dart';
import 'package:livros/home/bloc/home_page_event.dart';
import 'package:livros/home/bloc/home_page_state.dart';
import 'package:livros/models/livros_api_model.dart';
import 'package:livros/models/result_model.dart';
import 'package:mocktail/mocktail.dart';

class MockLivrosService extends Mock implements LivrosService {}

void main() {
  late MockLivrosService livrosService;
  late Repository repository;

  setUp(() {
    livrosService = MockLivrosService();
    repository = Repository(livrosService: livrosService);
  });

  group('HomePageBloc', () {
    test('initial state is idle', () {
      expect(
        HomePageBloc(repository: repository).state,
        HomePageState.initial(),
      );
    });

    blocTest<HomePageBloc, HomePageState>(
      'emits loading then success when search succeeds',
      setUp: () {
        when(() => livrosService.getBooks('programacao')).thenAnswer(
          (_) async => Result.success(const [
            Item(volumeInfo: VolumeInfo(title: 'Clean Code')),
          ]),
        );
      },
      build: () => HomePageBloc(repository: repository),
      act: (bloc) => bloc.add(const SearchEvent(categoria: 'programacao')),
      expect: () => [
        HomePageState(
          categoria: 'programacao',
          livros: Result.loading(),
        ),
        HomePageState(
          categoria: 'programacao',
          livros: Result.success(const [
            Item(volumeInfo: VolumeInfo(title: 'Clean Code')),
          ]),
        ),
      ],
    );

    blocTest<HomePageBloc, HomePageState>(
      'emits loading then error when search fails',
      setUp: () {
        when(() => livrosService.getBooks('programacao')).thenAnswer(
          (_) async => Result.error('Erro desconhecido.'),
        );
      },
      build: () => HomePageBloc(repository: repository),
      act: (bloc) => bloc.add(const SearchEvent(categoria: 'programacao')),
      expect: () => [
        HomePageState(
          categoria: 'programacao',
          livros: Result.loading(),
        ),
        HomePageState(
          categoria: 'programacao',
          livros: Result.error('Erro desconhecido.'),
        ),
      ],
    );

    blocTest<HomePageBloc, HomePageState>(
      'keeps last categoria when searching another one',
      setUp: () {
        when(() => livrosService.getBooks(any())).thenAnswer(
          (_) async => Result.success(const []),
        );
      },
      build: () => HomePageBloc(repository: repository),
      act: (bloc) async {
        bloc.add(const SearchEvent(categoria: 'programacao'));
        await Future<void>.delayed(Duration.zero);
        bloc.add(const SearchEvent(categoria: 'matematica'));
      },
      expect: () => [
        HomePageState(
          categoria: 'programacao',
          livros: Result.loading(),
        ),
        HomePageState(
          categoria: 'programacao',
          livros: Result.success(const []),
        ),
        HomePageState(
          categoria: 'matematica',
          livros: Result.loading(),
        ),
        HomePageState(
          categoria: 'matematica',
          livros: Result.success(const []),
        ),
      ],
    );
  });
}
