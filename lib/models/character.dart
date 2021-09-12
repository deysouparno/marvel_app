class CharacterWrapper {
  int code;
  String status;
  String copyright;
  String attributionText;
  String attributionHTML;
  String etag;
  Data data;

  CharacterWrapper(
      {required this.code,
      required this.status,
      required this.copyright,
      required this.attributionText,
      required this.attributionHTML,
      required this.etag,
      required this.data});

  factory CharacterWrapper.fromJson(Map<String, dynamic> json) {
    return CharacterWrapper(
        code: json['code'],
        status: json['status'],
        copyright: json['copyright'],
        attributionText: json['attributionText'],
        attributionHTML: json['attributionHTML'],
        etag: json['etag'],
        data: Data.fromJson(json['data']));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['copyright'] = this.copyright;
    data['attributionText'] = this.attributionText;
    data['attributionHTML'] = this.attributionHTML;
    data['etag'] = this.etag;
    data['data'] = this.data.toJson();

    return data;
  }
}

class Data {
  int offset;
  int limit;
  int total;
  int count;
  List<Character> characters;

  Data(
      {required this.offset,
      required this.limit,
      required this.total,
      required this.count,
      required this.characters});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
        offset: json['offset'],
        limit: json['limit'],
        total: json['total'],
        count: json['count'],
        characters: List.from(json['results'])
            .map((e) => Character.fromJson(e))
            .toList());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offset'] = this.offset;
    data['limit'] = this.limit;
    data['total'] = this.total;
    data['count'] = this.count;
    data['results'] = this.characters.map((v) => v.toJson()).toList();

    return data;
  }
}

class Character {
  int id;
  String name;
  String description;
  String modified;
  Thumbnail thumbnail;
  String resourceURI;
  Comics comics;
  Comics series;
  Stories stories;
  Comics events;
  List<Urls> urls;

  Character(
      {required this.id,
      required this.name,
      required this.description,
      required this.modified,
      required this.thumbnail,
      required this.resourceURI,
      required this.comics,
      required this.series,
      required this.stories,
      required this.events,
      required this.urls});

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        modified: json['modified'],
        thumbnail: Thumbnail.fromJson(json['thumbnail']),
        resourceURI: json['resourceURI'],
        comics: Comics.fromJson(json['comics']),
        series: Comics.fromJson(json['series']),
        stories: Stories.fromJson(json['stories']),
        events: Comics.fromJson(json['events']),
        urls: List.from(json['urls']).map((e) => Urls.fromJson(e)).toList());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['modified'] = this.modified;
    data['thumbnail'] = this.thumbnail.toJson();
    data['resourceURI'] = this.resourceURI;
    data['comics'] = this.comics.toJson();
    data['series'] = this.series.toJson();
    data['stories'] = this.stories.toJson();
    data['events'] = this.events.toJson();
    data['urls'] = this.urls.map((v) => v.toJson()).toList();
    return data;
  }
}

class Thumbnail {
  String path;
  String extension;

  Thumbnail({required this.path, required this.extension});

  factory Thumbnail.fromJson(Map<String, dynamic> json) {
    return Thumbnail(path: json['path'], extension: json['extension']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['path'] = this.path;
    data['extension'] = this.extension;
    return data;
  }
}

class Comics {
  int available;
  String collectionURI;
  List<Items> items;
  int returned;

  Comics(
      {required this.available,
      required this.collectionURI,
      required this.items,
      required this.returned});

  factory Comics.fromJson(Map<String, dynamic> json) {
    return Comics(
        available: json['available'],
        collectionURI: json['collectionURI'],
        items: List.from(json['items']).map((e) => Items.fromJson(e)).toList(),
        returned: json['returned']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['available'] = this.available;
    data['collectionURI'] = this.collectionURI;
    data['items'] = this.items.map((v) => v.toJson()).toList();
    data['returned'] = this.returned;
    return data;
  }
}

class Items {
  String resourceURI;
  String name;

  Items({required this.resourceURI, required this.name});

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(resourceURI: json['resourceURI'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resourceURI'] = this.resourceURI;
    data['name'] = this.name;
    return data;
  }
}

class StoryItem {
  String resourceURI;
  String name;
  String type;

  StoryItem(
      {required this.resourceURI, required this.name, required this.type});

  factory StoryItem.fromJson(Map<String, dynamic> json) {
    return StoryItem(
        resourceURI: json['resourceURI'],
        name: json['name'],
        type: json['type']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resourceURI'] = this.resourceURI;
    data['name'] = this.name;
    data['type'] = this.type;
    return data;
  }
}

class Urls {
  String type;
  String url;

  Urls({required this.type, required this.url});

  factory Urls.fromJson(Map<String, dynamic> json) {
    return Urls(type: json['type'], url: json['url']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['url'] = this.url;
    return data;
  }
}

class Stories {
  int available;
  String collectionURI;
  List<StoryItem> items;
  int returned;

  Stories(
      {required this.available,
      required this.collectionURI,
      required this.items,
      required this.returned});

  factory Stories.fromJson(Map<String, dynamic> json) {
    return Stories(
        available: json['available'],
        collectionURI: json['collectionURI'],
        items:
            List.from(json['items']).map((e) => StoryItem.fromJson(e)).toList(),
        returned: json['returned']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['available'] = this.available;
    data['collectionURI'] = this.collectionURI;
    data['items'] = this.items.map((v) => v.toJson()).toList();
    data['returned'] = this.returned;
    return data;
  }
}
