import 'package:marvel_app/models/character.dart';

class ComicWrapper {
  final int code;
  final String status;
  final ComicData comicData;

  ComicWrapper({
    required this.code,
    required this.status,
    required this.comicData,
  });

  ComicWrapper copyWith({
    int? code,
    String? status,
    ComicData? comicData,
  }) {
    return ComicWrapper(
      code: code ?? this.code,
      status: status ?? this.status,
      comicData: comicData ?? this.comicData,
    );
  }

  factory ComicWrapper.fromJson(Map<String, dynamic> map) {
    return ComicWrapper(
      code: map['code'],
      status: map['status'],
      comicData: ComicData.fromJson(map['data']),
    );
  }

  @override
  String toString() =>
      'ComicWrapper(code: $code, status: $status, comicData: $comicData)';
}

class ComicData {
  int offset;
  int limit;
  int total;
  int count;
  List<Comic> comics;
  ComicData({
    required this.offset,
    required this.limit,
    required this.total,
    required this.count,
    required this.comics,
  });

  ComicData copyWith({
    int? offset,
    int? limit,
    int? total,
    int? count,
    List<Comic>? comics,
  }) {
    return ComicData(
      offset: offset ?? this.offset,
      limit: limit ?? this.limit,
      total: total ?? this.total,
      count: count ?? this.count,
      comics: comics ?? this.comics,
    );
  }

  factory ComicData.fromJson(Map<String, dynamic> map) {
    return ComicData(
      offset: map['offset'],
      limit: map['limit'],
      total: map['total'],
      count: map['count'],
      comics: List.from(map['results'])
          .map((e) => Comic.fromJson(e))
          .toList(), //List<Comic>.from(map['results'].map((x) => Comic.fromJson(x))),
    );
  }

  @override
  String toString() {
    return 'ComicData(offset: $offset, limit: $limit, total: $total, count: $count, comics: $comics)';
  }
}

class Comic {
  final int id;
  final String title;
  String? description;
  final int pageCount;
  final Thumbnail thumbnail;
  final List<TextObject> textObjects;
  final List<Urls> urls;

  Comic(
      {required this.id,
      required this.title,
      required this.description,
      required this.pageCount,
      required this.thumbnail,
      required this.textObjects,
      required this.urls});

  Comic copyWith(
      {int? id,
      String? title,
      String? description,
      int? pageCount,
      Thumbnail? thumbnail,
      List<TextObject>? textObjects,
      List<Urls>? urls}) {
    return Comic(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        pageCount: pageCount ?? this.pageCount,
        thumbnail: thumbnail ?? this.thumbnail,
        textObjects: textObjects ?? this.textObjects,
        urls: urls ?? this.urls);
  }

  factory Comic.fromJson(Map<String, dynamic> map) {
    return Comic(
        id: map['id'],
        title: map['title'],
        description: map['description'],
        pageCount: map['pageCount'],
        thumbnail: Thumbnail.fromJson(map['thumbnail']),
        textObjects: List.from(map['textObjects'])
            .map((e) => TextObject.fromJson(e))
            .toList(),
        urls: List.from(map['urls'])
            .map((e) => Urls.fromJson(e))
            .toList()); //TextObject.fromJson(map['textObjects']));
  }

  @override
  String toString() {
    return 'Comic(id: $id, title: $title, description: $description, pageCount: $pageCount, thumbnail: $thumbnail)';
  }
}

class TextObject {
  final String type;
  final String language;
  final String text;
  TextObject({
    required this.type,
    required this.language,
    required this.text,
  });

  TextObject copyWith({
    String? type,
    String? language,
    String? text,
  }) {
    return TextObject(
      type: type ?? this.type,
      language: language ?? this.language,
      text: text ?? this.text,
    );
  }

  factory TextObject.fromJson(Map<String, dynamic> map) {
    return TextObject(
      type: map['type'],
      language: map['language'],
      text: map['text'],
    );
  }

  @override
  String toString() =>
      'TextObjects(type: $type, language: $language, text: $text)';
}


/*
import 'character.dart';

class ComicWrapper {
  int code;
  String status;
  String copyright;
  String attributionText;
  String attributionHTML;
  String etag;
  ComicData comicData;

  ComicWrapper(
      {required this.code,
      required this.status,
      required this.copyright,
      required this.attributionText,
      required this.attributionHTML,
      required this.etag,
      required this.comicData});

  factory ComicWrapper.fromJson(Map<String, dynamic> json) {
    return ComicWrapper(
        code: json['code'],
        status: json['status'],
        copyright: json['copyright'],
        attributionText: json['attributionText'],
        attributionHTML: json['attributionHTML'],
        etag: json['etag'],
        comicData: ComicData.fromJson(json['data']));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> ComicData = new Map<String, dynamic>();
    ComicData['code'] = this.code;
    ComicData['status'] = this.status;
    ComicData['copyright'] = this.copyright;
    ComicData['attributionText'] = this.attributionText;
    ComicData['attributionHTML'] = this.attributionHTML;
    ComicData['etag'] = this.etag;
    ComicData['data'] = this.comicData.toJson();
    return ComicData;
  }
}

class ComicData {
  int offset;
  int limit;
  int total;
  int count;
  List<Comic> comics;

  ComicData(
      {required this.offset,
      required this.limit,
      required this.total,
      required this.count,
      required this.comics});

  factory ComicData.fromJson(Map<String, dynamic> json) {
    return ComicData(
    offset: json['offset'],
    limit: json['limit'],
    total: json['total'],
    count: json['count'],
    comics: List.from(json['results']).map((e) => Comic.fromJson(e)).toList());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> comicData = new Map<String, dynamic>();
    comicData['offset'] = this.offset;
    comicData['limit'] = this.limit;
    comicData['total'] = this.total;
    comicData['count'] = this.count;
    comicData['results'] = this.comics.map((v) => v.toJson()).toList();
    return comicData;
  }
}

class Comic {
  int id;
  int digitalId;
  String title;
  int issueNumber;
  String variantDescription;
  String description;
  String modified;
  String isbn;
  String upc;
  String diamondCode;
  String ean;
  String issn;
  String format;
  int pageCount;
  List<TextObjects> textObjects;
  String resourceURI;
  List<Urls> urls;
  Series series;
  List<Variants> variants;
  List<Null> collections;
  List<Null> collectedIssues;
  List<Dates> dates;
  List<Prices> prices;
  Thumbnail thumbnail;
  List<Images> images;
  Creators creators;
  Creators characters;
  Creators stories;
  Creators events;

  Comic(
      {required this.id,
      required this.digitalId,
      required this.title,
      required this.issueNumber,
      required this.variantDescription,
      required this.description,
      required this.modified,
      required this.isbn,
      required this.upc,
      required this.diamondCode,
      required this.ean,
      required this.issn,
      required this.format,
      required this.pageCount,
      required this.textObjects,
      required this.resourceURI,
      required this.urls,
      required this.series,
      this.variants,
      this.collections,
      this.collectedIssues,
      this.dates,
      this.prices,
      this.thumbnail,
      this.images,
      this.creators,
      this.characters,
      this.stories,
      this.events});

  Comic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    digitalId = json['digitalId'];
    title = json['title'];
    issueNumber = json['issueNumber'];
    variantDescription = json['variantDescription'];
    description = json['description'];
    modified = json['modified'];
    isbn = json['isbn'];
    upc = json['upc'];
    diamondCode = json['diamondCode'];
    ean = json['ean'];
    issn = json['issn'];
    format = json['format'];
    pageCount = json['pageCount'];
    if (json['textObjects'] != null) {
      textObjects = new List<TextObjects>();
      json['textObjects'].forEach((v) {
        textObjects.add(new TextObjects.fromJson(v));
      });
    }
    resourceURI = json['resourceURI'];
    if (json['urls'] != null) {
      urls = new List<Urls>();
      json['urls'].forEach((v) {
        urls.add(new Urls.fromJson(v));
      });
    }
    series =
        json['series'] != null ? new Series.fromJson(json['series']) : null;
    if (json['variants'] != null) {
      variants = new List<Variants>();
      json['variants'].forEach((v) {
        variants.add(new Variants.fromJson(v));
      });
    }
    if (json['collections'] != null) {
      collections = new List<Null>();
      json['collections'].forEach((v) {
        collections.add(new Null.fromJson(v));
      });
    }
    if (json['collectedIssues'] != null) {
      collectedIssues = new List<Null>();
      json['collectedIssues'].forEach((v) {
        collectedIssues.add(new Null.fromJson(v));
      });
    }
    if (json['dates'] != null) {
      dates = new List<Dates>();
      json['dates'].forEach((v) {
        dates.add(new Dates.fromJson(v));
      });
    }
    if (json['prices'] != null) {
      prices = new List<Prices>();
      json['prices'].forEach((v) {
        prices.add(new Prices.fromJson(v));
      });
    }
    thumbnail = json['thumbnail'] != null
        ? new Thumbnail.fromJson(json['thumbnail'])
        : null;
    if (json['images'] != null) {
      images = new List<Images>();
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
    creators = json['creators'] != null
        ? new Creators.fromJson(json['creators'])
        : null;
    characters = json['characters'] != null
        ? new Creators.fromJson(json['characters'])
        : null;
    stories =
        json['stories'] != null ? new Creators.fromJson(json['stories']) : null;
    events =
        json['events'] != null ? new Creators.fromJson(json['events']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> ComicData = new Map<String, dynamic>();
    ComicData['id'] = this.id;
    ComicData['digitalId'] = this.digitalId;
    ComicData['title'] = this.title;
    ComicData['issueNumber'] = this.issueNumber;
    ComicData['variantDescription'] = this.variantDescription;
    ComicData['description'] = this.description;
    ComicData['modified'] = this.modified;
    ComicData['isbn'] = this.isbn;
    ComicData['upc'] = this.upc;
    ComicData['diamondCode'] = this.diamondCode;
    ComicData['ean'] = this.ean;
    ComicData['issn'] = this.issn;
    ComicData['format'] = this.format;
    ComicData['pageCount'] = this.pageCount;
    if (this.textObjects != null) {
      ComicData['textObjects'] = this.textObjects.map((v) => v.toJson()).toList();
    }
    ComicData['resourceURI'] = this.resourceURI;
    if (this.urls != null) {
      ComicData['urls'] = this.urls.map((v) => v.toJson()).toList();
    }
    if (this.series != null) {
      ComicData['series'] = this.series.toJson();
    }
    if (this.variants != null) {
      ComicData['variants'] = this.variants.map((v) => v.toJson()).toList();
    }
    if (this.collections != null) {
      ComicData['collections'] = this.collections.map((v) => v.toJson()).toList();
    }
    if (this.collectedIssues != null) {
      ComicData['collectedIssues'] =
          this.collectedIssues.map((v) => v.toJson()).toList();
    }
    if (this.dates != null) {
      ComicData['dates'] = this.dates.map((v) => v.toJson()).toList();
    }
    if (this.prices != null) {
      ComicData['prices'] = this.prices.map((v) => v.toJson()).toList();
    }
    if (this.thumbnail != null) {
      ComicData['thumbnail'] = this.thumbnail.toJson();
    }
    if (this.images != null) {
      ComicData['images'] = this.images.map((v) => v.toJson()).toList();
    }
    if (this.creators != null) {
      ComicData['creators'] = this.creators.toJson();
    }
    if (this.characters != null) {
      ComicData['characters'] = this.characters.toJson();
    }
    if (this.stories != null) {
      ComicData['stories'] = this.stories.toJson();
    }
    if (this.events != null) {
      ComicData['events'] = this.events.toJson();
    }
    return ComicData;
  }
}

class TextObjects {
  String type;
  String language;
  String text;

  TextObjects({this.type, this.language, this.text});

  TextObjects.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    language = json['language'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> ComicData = new Map<String, dynamic>();
    ComicData['type'] = this.type;
    ComicData['language'] = this.language;
    ComicData['text'] = this.text;
    return ComicData;
  }
}

// class Urls {
//   String type;
//   String url;

//   Urls({this.type, this.url});

//   Urls.fromJson(Map<String, dynamic> json) {
//     type = json['type'];
//     url = json['url'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> ComicData = new Map<String, dynamic>();
//     ComicData['type'] = this.type;
//     ComicData['url'] = this.url;
//     return ComicData;
//   }
// }

class Series {
  String resourceURI;
  String name;

  Series({this.resourceURI, this.name});

  Series.fromJson(Map<String, dynamic> json) {
    resourceURI = json['resourceURI'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> ComicData = new Map<String, dynamic>();
    ComicData['resourceURI'] = this.resourceURI;
    ComicData['name'] = this.name;
    return ComicData;
  }
}

class Dates {
  String type;
  String date;

  Dates({this.type, this.date});

  Dates.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> ComicData = new Map<String, dynamic>();
    ComicData['type'] = this.type;
    ComicData['date'] = this.date;
    return ComicData;
  }
}

class Prices {
  String type;
  double price;

  Prices({this.type, this.price});

  Prices.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> ComicData = new Map<String, dynamic>();
    ComicData['type'] = this.type;
    ComicData['price'] = this.price;
    return ComicData;
  }
}

class Thumbnail {
  String path;
  String extension;

  Thumbnail({this.path, this.extension});

  Thumbnail.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    extension = json['extension'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> ComicData = new Map<String, dynamic>();
    ComicData['path'] = this.path;
    ComicData['extension'] = this.extension;
    return ComicData;
  }
}

class Creators {
  int available;
  String collectionURI;
  List<Items> items;
  int returned;

  Creators({this.available, this.collectionURI, this.items, this.returned});

  Creators.fromJson(Map<String, dynamic> json) {
    available = json['available'];
    collectionURI = json['collectionURI'];
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
    returned = json['returned'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> ComicData = new Map<String, dynamic>();
    ComicData['available'] = this.available;
    ComicData['collectionURI'] = this.collectionURI;
    if (this.items != null) {
      ComicData['items'] = this.items.map((v) => v.toJson()).toList();
    }
    ComicData['returned'] = this.returned;
    return ComicData;
  }
}

class Items {
  String resourceURI;
  String name;
  String role;

  Items({this.resourceURI, this.name, this.role});

  Items.fromJson(Map<String, dynamic> json) {
    resourceURI = json['resourceURI'];
    name = json['name'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> ComicData = new Map<String, dynamic>();
    ComicData['resourceURI'] = this.resourceURI;
    ComicData['name'] = this.name;
    ComicData['role'] = this.role;
    return ComicData;
  }
}

class Items {
  String resourceURI;
  String name;
  String type;

  Items({this.resourceURI, this.name, this.type});

  Items.fromJson(Map<String, dynamic> json) {
    resourceURI = json['resourceURI'];
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> ComicData = new Map<String, dynamic>();
    ComicData['resourceURI'] = this.resourceURI;
    ComicData['name'] = this.name;
    ComicData['type'] = this.type;
    return ComicData;
  }
}

*/
