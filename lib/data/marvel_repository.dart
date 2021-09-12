import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:marvel_app/constants.dart';
import 'package:marvel_app/models/character.dart';

import '../models/comic.dart';

class MarvelRepository {
  static bool hasNext = true;
  static List<Character> characters = [];
  static List<Character> searchCharacters = [];

  static Future<void> getAllCharacter({int offest = 0}) async {
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
}
