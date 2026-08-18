import 'package:equatable/equatable.dart';

class LivrosApiModel extends Equatable {
  const LivrosApiModel({
    this.totalItems,
    this.kind,
    this.items,
  });

  factory LivrosApiModel.fromJson(Map<String, dynamic> parsedJson) {
    final list = parsedJson['items'] as List<dynamic>? ?? const [];

    return LivrosApiModel(
      items: list.whereType<Map<String, dynamic>>().map(Item.fromJson).toList(),
      kind: parsedJson['kind'] as String?,
      totalItems: parsedJson['totalItems'] as int?,
    );
  }

  final int? totalItems;
  final String? kind;
  final List<Item>? items;

  @override
  List<Object?> get props => [totalItems, kind, items];
}

class Item extends Equatable {
  const Item({
    this.kind,
    this.etag,
    this.volumeInfo,
  });

  factory Item.fromJson(Map<String, dynamic> parsedJson) {
    final volumeInfo = parsedJson['volumeInfo'];
    return Item(
      kind: parsedJson['kind'] as String?,
      etag: parsedJson['etag'] as String?,
      volumeInfo: volumeInfo is Map<String, dynamic>
          ? VolumeInfo.fromJson(volumeInfo)
          : null,
    );
  }

  final String? kind;
  final String? etag;
  final VolumeInfo? volumeInfo;

  @override
  List<Object?> get props => [kind, etag, volumeInfo];
}

class VolumeInfo extends Equatable {
  const VolumeInfo({
    this.title,
    this.publisher,
    this.printType,
    this.image,
  });

  factory VolumeInfo.fromJson(Map<String, dynamic> parsedJson) {
    final imageLinks = parsedJson['imageLinks'];
    return VolumeInfo(
      title: parsedJson['title'] as String?,
      publisher: parsedJson['publisher'] as String?,
      printType: parsedJson['printType'] as String?,
      image: imageLinks is Map<String, dynamic>
          ? ImageLinks.fromJson(imageLinks)
          : null,
    );
  }

  final String? title;
  final String? publisher;
  final String? printType;
  final ImageLinks? image;

  @override
  List<Object?> get props => [title, publisher, printType, image];
}

class ImageLinks extends Equatable {
  const ImageLinks({this.thumbnail});

  factory ImageLinks.fromJson(Map<String, dynamic> parsedJson) {
    return ImageLinks(
      thumbnail: parsedJson['thumbnail'] as String?,
    );
  }

  final String? thumbnail;

  @override
  List<Object?> get props => [thumbnail];
}

class ISBN extends Equatable {
  const ISBN({this.isbn13, this.type});

  factory ISBN.fromJson(Map<String, dynamic> parsedJson) {
    return ISBN(
      isbn13: parsedJson['identifier'] as String?,
      type: parsedJson['type'] as String?,
    );
  }

  final String? isbn13;
  final String? type;

  @override
  List<Object?> get props => [isbn13, type];
}
