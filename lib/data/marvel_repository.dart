import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:marvel_app/constants.dart';
import 'package:marvel_app/models/character.dart';

import '../models/comic.dart';

class MarvelRepository {
  static bool hasNext = true;
  static List<Character> characters = [];
  static List<Character> searchCharacters = [];
  static List<Comic> comics = [];
  static List<Comic> searchComics = [];

  static Future<void> getAllCharacter({int offest = 0}) async {
    print("getting all characters");
    var uri = Uri.https(Constatnts.BASE_URL, "/v1/public/characters", {
      'ts': '${Constatnts.TIME_STAMP}',
      'apikey': '${Constatnts.PUBLIC_KEY}',
      'hash': '${Constatnts.HASH}',
      'offset': "$offest"
    });

    var res = await http.get(uri);

    if (res.statusCode == 200) {
      var wrapper = CharacterWrapper.fromJson(jsonDecode(res.body));

      characters = wrapper.data.characters;

      hasNext = wrapper.data.count == 20;
    }
  }

  static Future<void> searchCharacter({required String name}) async {
    var uri = Uri.https(Constatnts.BASE_URL, "/v1/public/characters", {
      'ts': '${Constatnts.TIME_STAMP}',
      'apikey': '${Constatnts.PUBLIC_KEY}',
      'hash': '${Constatnts.HASH}',
      'nameStartsWith': '$name'
    });

    var res = await http.get(uri);
    if (res.statusCode == 200) {
      var wrapper = CharacterWrapper.fromJson(jsonDecode(res.body));
      searchCharacters = wrapper.data.characters;
    }
  }

  static Future<void> getAllComics({int offest = 0}) async {
    var uri = Uri.https(Constatnts.BASE_URL, "/v1/public/comics", {
      'ts': '${Constatnts.TIME_STAMP}',
      'apikey': '${Constatnts.PUBLIC_KEY}',
      'hash': '${Constatnts.HASH}',
      'offset': "$offest"
    });

    var res = await http.get(uri);

    if (res.statusCode == 200) {
      var wrapper = ComicWrapper.fromJson(jsonDecode(res.body));

      comics = wrapper.comicData.comics;

      hasNext = wrapper.comicData.count == 20;
    }
  }

  static Future<void> searchComic({required String name}) async {
    var uri = Uri.https(Constatnts.BASE_URL, "/v1/public/comics", {
      'ts': '${Constatnts.TIME_STAMP}',
      'apikey': '${Constatnts.PUBLIC_KEY}',
      'hash': '${Constatnts.HASH}',
      'titleStartsWith': '$name'
    });

    var res = await http.get(uri);
    if (res.statusCode == 200) {
      var wrapper = ComicWrapper.fromJson(jsonDecode(res.body));
      searchComics = wrapper.comicData.comics;
    }
  }
}
