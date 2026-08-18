# Livros

[![Flutter](https://img.shields.io/badge/Flutter-3.47-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.13-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![style: very_good_analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)

A Flutter book search app powered by the Google Books API, built with [bloc](https://pub.dev/packages/bloc). The project where bloc started to make sense to me.

![Livros banner](./screenshots/banner.webp)

## Features

- Browse books by category
- Google Books API integration
- State management with [bloc](https://pub.dev/packages/bloc)
- Null safety and Material 3

## Getting Started

1. Clone the repository.
2. Run `flutter pub get`.
3. Run `flutter run`.

> The Google Books API has a public quota. If the quota is exhausted, the app shows the error state instead of results.

## Testing

```sh
flutter test
```

The suite covers the data layer (models and service), the bloc logic, and the UI widgets.

## Technologies

- Flutter / Dart
- [bloc](https://pub.dev/packages/bloc) and [flutter_bloc](https://pub.dev/packages/flutter_bloc)
- [equatable](https://pub.dev/packages/equatable)
- [http](https://pub.dev/packages/http)

## License

[MIT](./LICENSE)

## Acknowledgments

Inspired by the Flutter and bloc video series by [Pedro Massango](https://www.youtube.com/playlist?list=PLum90SMJW-vn-1p0JdIrTuZfjNqNT2V6E). Thanks, Pedro!
