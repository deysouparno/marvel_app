import 'dart:convert';

import 'package:marvel_app/models/character.dart';
import 'package:marvel_app/models/comic.dart';

import '../constants.dart';

import 'package:http/http.dart' as http;

class CharacterDetailsRepo {
  static List<Comic> comicsForCharacter = [];

  static Future<void> searchComicsForCharacter(Character character) async {
    var uri = Uri.https(
        Constatnts.BASE_URL, "/v1/public/characters/${character.id}/comics", {
      'ts': '${Constatnts.TIME_STAMP}',
      'apikey': '${Constatnts.PUBLIC_KEY}',
      'hash': '${Constatnts.HASH}',
    });

    var res = await http.get(uri);

    if (res.statusCode == 200) {
      try {
        var wrapper = ComicWrapper.fromJson(jsonDecode(res.body));

        comicsForCharacter = wrapper.comicData.comics;
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
