import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import 'package:marvel_app/cubits/search/search_cubit.dart';
import 'package:marvel_app/models/character.dart';
import 'package:marvel_app/ui/screens/character_details.dart';
import 'package:marvel_app/ui/widgets/mycard.dart';

import '../../constants.dart';
import '../../data/marvel_repository.dart';

class CharacterPage extends StatefulWidget {
  final VoidCallback openDrawer;
  final bool shouldRefresh;
  CharacterPage({
    Key? key,
    required this.openDrawer,
    required this.shouldRefresh,
  }) : super(key: key);

  @override
  _CharacterPageState createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  List<Character> characters = MarvelRepository.characters;
  void fetch({int? offest}) async {
    int val = Random().nextInt(1500);
    if (offest != null) {
      val = offest;
    }
    BlocProvider.of<CharacterPageStateCubit>(context).emitRefreshing();
    await MarvelRepository.getAllCharacter(offest: val);
    characters = MarvelRepository.characters;
    BlocProvider.of<CharacterPageStateCubit>(context).emitNotSearching();
  }

  void searchCharacter({required String name}) async {
    BlocProvider.of<CharacterPageStateCubit>(context).emitSearching();
    await MarvelRepository.searchCharacter(name: name);
    print("search complete");
    characters = MarvelRepository.searchCharacters;
    BlocProvider.of<CharacterPageStateCubit>(context).emitDoneSearching();
  }

  @override
  void initState() {
    if (widget.shouldRefresh) fetch();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _searchController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.grey[700],
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              widget.openDrawer();
            },
            icon: Icon(Icons.menu)),
        title: BlocBuilder<CharacterPageStateCubit, SearchState>(
            builder: (context, state) {
          return AnimatedSwitcher(
            duration: Duration(milliseconds: 200),
            reverseDuration: Duration(milliseconds: 200),
            transitionBuilder: (child, animation) {
              var animationOffset = animation
                  .drive(Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0)));

              return SlideTransition(
                position: animationOffset,
                child: child,
              );
            },
            child: state is NotSearching || state is Refreshing
                ? Text("Characters")
                : Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          minLines: 1,
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            searchCharacter(name: _searchController.text);
                          },
                          child: Text("Search"))
                    ],
                  ),
          );
        }),
        actions: [
          BlocBuilder<CharacterPageStateCubit, SearchState>(
              builder: (context, state) {
            if (!(state is NotSearching || state is Refreshing)) {
              return IconButton(
                  onPressed: () {
                    characters = MarvelRepository.characters;
                    BlocProvider.of<CharacterPageStateCubit>(context)
                        .emitNotSearching();
                  },
                  icon: Icon(Icons.close));
            } else {
              return IconButton(
                  onPressed: () {
                    BlocProvider.of<CharacterPageStateCubit>(context)
                        .emitTyping();
                  },
                  icon: Icon(Icons.search));
            }
          })
        ],
      ),
      body: BlocBuilder<CharacterPageStateCubit, SearchState>(
        builder: (context, state) {
          if (state is Searching || state is Refreshing) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          print("charcter loading");
          return RefreshIndicator(
            onRefresh: () async {
              await MarvelRepository.getAllCharacter(
                  offest: Random().nextInt(1500));
              characters = MarvelRepository.characters;
              BlocProvider.of<CharacterPageStateCubit>(context)
                  .emitNotSearching();
            },
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: characters.length,
                itemBuilder: (context, index) {
                  Character character = characters[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              CharacterDetails(character: character)));
                    },
                    child: Container(
                      height: 200,
                      width: 200,
                      child: getCard(
                          url:
                              "${character.thumbnail.path.replaceFirst("http", "https")}/${Constatnts.BEST_QUALITY}${character.thumbnail.extension}",
                          text: character.name),
                    ),
                  );
                }),
          );
        },
      ),
    );
  }
}
