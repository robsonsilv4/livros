import 'package:flutter/material.dart';

class LivroWidget extends StatelessWidget {
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                'https://picsum.photos/240',
                width: 200,
                height: 240,
                fit: BoxFit.cover,
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
                    'Aprenda React com Flutter',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Robson Silva',
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
