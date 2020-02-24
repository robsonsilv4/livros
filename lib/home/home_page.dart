import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'livro_widget.dart';

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

  @override
  void initState() {
    // Para tela cheia
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
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
                          onTap: () {
                            _categoriaSelecionada = index;
                            setState(() {});
                          },
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
              Expanded(
                child: ListView.builder(
                  itemCount: categorias.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return LivroWidget();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
