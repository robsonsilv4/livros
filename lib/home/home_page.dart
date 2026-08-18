import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livros/home/bloc/home_page_bloc.dart';
import 'package:livros/home/bloc/home_page_event.dart';
import 'package:livros/home/bloc/home_page_state.dart';
import 'package:livros/models/result_status_model.dart';
import 'package:livros/widgets/livro_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const List<String> categorias = [
    'autoajuda',
    'programacao',
    'matematica',
    'literatura',
    'religiao',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 24),
                    child: Text(
                      'Procurar',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    'Recomendados',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
            ),
            BlocBuilder<HomePageBloc, HomePageState>(
              builder: (context, state) {
                return SizedBox(
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 16),
                    itemCount: categorias.length,
                    itemBuilder: (context, index) {
                      final categoria = categorias[index];
                      final categoriaCapitalizada =
                          categoria[0].toUpperCase() + categoria.substring(1);
                      final categoriaSelecionada = categoria == state.categoria;

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: GestureDetector(
                          onTap: () {
                            context.read<HomePageBloc>().add(
                              SearchEvent(categoria: categoria),
                            );
                          },
                          child: Chip(
                            backgroundColor: categoriaSelecionada
                                ? Colors.blue
                                : Colors.grey.shade200,
                            label: Text(
                              categoriaCapitalizada,
                              style: TextStyle(
                                color: categoriaSelecionada
                                    ? Colors.white
                                    : Colors.grey.shade500,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            BlocBuilder<HomePageBloc, HomePageState>(
              builder: (context, state) {
                if (state.livros.status == ResultStatus.error) {
                  return Expanded(
                    child: Center(
                      child: Text(state.livros.error ?? 'Erro desconhecido.'),
                    ),
                  );
                }

                if (state.livros.status == ResultStatus.success) {
                  final livros = state.livros.data ?? const [];

                  return Expanded(
                    child: ListView.builder(
                      itemCount: livros.length,
                      itemBuilder: (context, index) {
                        return LivroWidget(livro: livros[index]);
                      },
                    ),
                  );
                }

                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
