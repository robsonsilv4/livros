import 'package:flutter/material.dart';

import '../models/livros_api_model.dart';

class LivroWidget extends StatelessWidget {
  final Item livro;

  LivroWidget({@required this.livro}) : assert(livro != null);

  VolumeInfo get livroInfo => livro.volumeinfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 250,
      margin: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 200.0,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.0,
                  color: Colors.grey.shade300,
                ),
                borderRadius: BorderRadius.circular(12.0),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(livroInfo.image.thumb),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 220,
              height: 200,
              padding: EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 15,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    livroInfo.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    livroInfo.publisher,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
