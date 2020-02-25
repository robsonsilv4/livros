import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository.dart';
import '../widgets/livro_widget.dart';
import 'bloc/home_page_bloc.dart';
import 'bloc/home_page_event.dart';
import 'bloc/home_page_state.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> categorias = [
    'Autoajuda',
    'Programação',
    'Matemática',
    'Ficção',
    'Religião',
  ];

  int _categoriaSelecionada = 0;

  HomePageBloc _bloc;

  @override
  void initState() {
    super.initState();
    // Para tela cheia
    SystemChrome.setEnabledSystemUIOverlays([]);

    _bloc = HomePageBloc(repository: Repository());

    _bloc.add(SearchEvent(query: categorias[0]));
  }

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
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 24.0),
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
              Container(
                height: 80,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: categorias.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: GestureDetector(
                          onTap: () => _onCategorySelected(index),
                          child: Chip(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            backgroundColor: index == _categoriaSelecionada
                                ? Colors.blue
                                : Colors.grey.shade200,
                            label: Text(
                              categorias.elementAt(index),
                              style: TextStyle(
                                  color: index == _categoriaSelecionada
                                      ? Colors.white
                                      : Colors.grey.shade500),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              BlocBuilder<HomePageBloc, HomePageState>(
                bloc: _bloc,
                builder: (context, state) {
                  if (state is ErrorState) {
                    return Center(
                      child: Text(state.mensagem),
                    );
                  }

                  if (state is LoadedState) {
                    final livros = state.livros;

                    return Expanded(
                      child: ListView.builder(
                        itemCount: livros.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final item = livros.elementAt(index);
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

  _onCategorySelected(int index) {
    setState(() {
      _categoriaSelecionada = index;
    });

    final categoria = categorias[index];
    _bloc.add(SearchEvent(query: categoria));
  }
}
