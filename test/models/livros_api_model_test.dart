import 'package:flutter_test/flutter_test.dart';
import 'package:livros/models/livros_api_model.dart';

void main() {
  group(LivrosApiModel, () {
    group('fromJson', () {
      test('parses a complete payload', () {
        final model = LivrosApiModel.fromJson(const {
          'kind': 'books#volumes',
          'totalItems': 1,
          'items': [
            {
              'kind': 'books#volume',
              'etag': 'abc',
              'volumeInfo': {
                'title': 'Clean Code',
                'publisher': 'Prentice Hall',
                'printType': 'BOOK',
                'imageLinks': {'thumbnail': 'https://example.com/thumb.jpg'},
              },
            },
          ],
        });

        expect(model.kind, 'books#volumes');
        expect(model.totalItems, 1);
        expect(model.items, hasLength(1));
        expect(model.items!.first.volumeInfo!.title, 'Clean Code');
        expect(
          model.items!.first.volumeInfo!.image!.thumbnail,
          'https://example.com/thumb.jpg',
        );
      });

      test('parses empty payload', () {
        final model = LivrosApiModel.fromJson(const {});

        expect(model.kind, isNull);
        expect(model.totalItems, isNull);
        expect(model.items, isEmpty);
      });

      test('parses payload without items key', () {
        final model = LivrosApiModel.fromJson(const {'kind': 'books#volumes'});

        expect(model.items, isEmpty);
      });
    });
  });

  group(Item, () {
    group('fromJson', () {
      test('parses item without volumeInfo', () {
        final item = Item.fromJson(const {'kind': 'books#volume', 'etag': 'x'});

        expect(item.kind, 'books#volume');
        expect(item.etag, 'x');
        expect(item.volumeInfo, isNull);
      });
    });
  });

  group(VolumeInfo, () {
    group('fromJson', () {
      test('parses volumeInfo without imageLinks', () {
        final info = VolumeInfo.fromJson(const {'title': 'Dart'});

        expect(info.title, 'Dart');
        expect(info.image, isNull);
      });
    });
  });

  group(ImageLinks, () {
    group('fromJson', () {
      test('parses thumbnail', () {
        final links = ImageLinks.fromJson(const {
          'thumbnail': 'https://example.com/a.jpg',
        });

        expect(links.thumbnail, 'https://example.com/a.jpg');
      });

      test('parses without thumbnail', () {
        final links = ImageLinks.fromJson(const {});

        expect(links.thumbnail, isNull);
      });
    });
  });

  group(ISBN, () {
    group('fromJson', () {
      test('parses identifier', () {
        final isbn = ISBN.fromJson(
          const {'identifier': '978-1-23', 'type': 'ISBN_13'},
        );

        expect(isbn.isbn13, '978-1-23');
        expect(isbn.type, 'ISBN_13');
      });
    });
  });
}
