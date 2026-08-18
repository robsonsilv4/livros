import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:livros/models/livros_api_model.dart';
import 'package:livros/widgets/livro_widget.dart';

import '../helpers/helpers.dart';

void main() {
  group(LivroWidget, () {
    testWidgets('renders title and publisher', (tester) async {
      await tester.pumpApp(
        const Scaffold(
          body: LivroWidget(
            livro: Item(
              volumeInfo: VolumeInfo(
                title: 'Clean Code',
                publisher: 'Prentice Hall',
              ),
            ),
          ),
        ),
      );

      expect(find.text('Clean Code'), findsOneWidget);
      expect(find.text('Prentice Hall'), findsOneWidget);
    });

    testWidgets('renders fallback when no title', (tester) async {
      await tester.pumpApp(
        const Scaffold(
          body: LivroWidget(livro: Item(volumeInfo: VolumeInfo())),
        ),
      );

      expect(find.text('Sem título'), findsOneWidget);
    });

    testWidgets('renders without image when thumbnail is null', (tester) async {
      await tester.pumpApp(
        const Scaffold(
          body: LivroWidget(livro: Item(volumeInfo: VolumeInfo())),
        ),
      );

      expect(tester.takeException(), isNull);
      expect(find.byType(Image), findsNothing);
    });
  });
}
