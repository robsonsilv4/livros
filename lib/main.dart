import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:livros/data/livro_service.dart';
import 'package:livros/data/repository.dart';
import 'package:livros/home/bloc/home_page_bloc.dart';
import 'package:livros/home/home_page.dart';

void main() {
  runApp(const LivrosApp());
}

class LivrosApp extends StatelessWidget {
  const LivrosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomePageBloc(
        repository: Repository(
          livrosService: LivrosService(),
        ),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Livros',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        home: const HomePage(),
      ),
    );
  }
}
