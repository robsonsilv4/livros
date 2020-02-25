import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/livro_service.dart';
import 'data/repository.dart';
import 'home/bloc/home_page_bloc.dart';
import 'home/home_page.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  HomePageBloc _homePageBloc;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);

    final livroService = LivrosService();
    final repository = Repository(
      livrosService: livroService,
    );

    _homePageBloc = HomePageBloc(repository: repository);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _homePageBloc,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Livros',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}
