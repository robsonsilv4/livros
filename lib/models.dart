class LivrosApiModel {
  final int totalItems;
  final String kind;
  final List<Item> items;

  LivrosApiModel({this.items, this.kind, this.totalItems});

  factory LivrosApiModel.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['items'] as List;

    List<Item> itemList = list.map((i) => Item.fromJson(i)).toList();

    return LivrosApiModel(
        items: itemList,
        kind: parsedJson['kind'],
        totalItems: parsedJson['totalItems']);
  }
}

class Item {
  final String kind;
  final String etag;
  final VolumeInfo volumeinfo;

  Item({this.kind, this.etag, this.volumeinfo});

  factory Item.fromJson(Map<String, dynamic> parsedJson) {
    return Item(
        kind: parsedJson['kind'],
        etag: parsedJson['etag'],
        volumeinfo: VolumeInfo.fromJson(parsedJson['volumeInfo']));
  }
}

class VolumeInfo {
  final String title;
  final String publisher;
  final String printType;
  final ImageLinks image;

  VolumeInfo({
    this.printType,
    this.title,
    this.publisher,
    this.image,
  });

  factory VolumeInfo.fromJson(Map<String, dynamic> parsedJson) {
    return VolumeInfo(
      title: parsedJson['title'],
      publisher: parsedJson['publisher'],
      printType: parsedJson['printType'],
      image: ImageLinks.fromJson(
        parsedJson['imageLinks'],
      ),
    );
  }
}

class ImageLinks {
  final String thumb;

  ImageLinks({this.thumb});

  factory ImageLinks.fromJson(Map<String, dynamic> parsedJson) {
    return ImageLinks(thumb: parsedJson['thumbnail']);
  }
}

class ISBN {
  final String iSBN13;
  final String type;

  ISBN({this.iSBN13, this.type});

  factory ISBN.fromJson(Map<String, dynamic> parsedJson) {
    return ISBN(
      iSBN13: parsedJson['identifier'],
      type: parsedJson['type'],
    );
  }
}
