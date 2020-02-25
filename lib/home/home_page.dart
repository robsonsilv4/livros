import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/result_status_model.dart';
import '../widgets/livro_widget.dart';
import 'bloc/home_page_bloc.dart';
import 'bloc/home_page_event.dart';
import 'bloc/home_page_state.dart';

class HomePage extends StatelessWidget {
  final List<String> categorias = [
    'Autoajuda',
    'Programação',
    'Matemática',
    'litertura',
    'Religião',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Padding(
                      padding: EdgeInsets.only(right: 24.0),
                      child: Text(
                        'Procurar',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
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
                  )
                ],
              ),
              BlocBuilder<HomePageBloc, HomePageState>(
                  bloc: BlocProvider.of<HomePageBloc>(context),
                  builder: (context, state) {
                    return Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(left: 16.0),
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: categorias.length,
                          itemBuilder: (context, index) {
                            final categoria = categorias.elementAt(index);
                            print(categoria);
                            final categoriaSelecionada =
                                categoria == state.categoria;
                            print(categoriaSelecionada);

                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6.0),
                              child: GestureDetector(
                                onTap: () {
                                  BlocProvider.of<HomePageBloc>(context).add(
                                    SearchEvent(categoria: categoria),
                                  );
                                },
                                child: Chip(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  backgroundColor: categoriaSelecionada
                                      ? Colors.blue
                                      : Colors.grey.shade200,
                                  label: Text(
                                    categoria,
                                    style: TextStyle(
                                      color: categoriaSelecionada
                                          ? Colors.white
                                          : Colors.grey.shade500,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
                  }),
              BlocBuilder<HomePageBloc, HomePageState>(
                bloc: BlocProvider.of<HomePageBloc>(context),
                builder: (context, state) {
                  if (state.livros.status == ResultStatus.error) {
                    return Center(
                      child: Text(state.livros.error),
                    );
                  }

                  if (state.livros.status == ResultStatus.success) {
                    final livros = state.livros;

                    return Expanded(
                      child: ListView.builder(
                        itemCount: livros.data.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final item = livros.data.elementAt(index);
                          return LivroWidget(
                            livro: item,
                          );
                        },
                      ),
                    );
                  }

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
