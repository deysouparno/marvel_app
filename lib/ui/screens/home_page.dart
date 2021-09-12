import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:marvel_app/cubits/cubit/search_cubit.dart';
import 'package:marvel_app/models/character.dart';
import 'package:marvel_app/ui/screens/character_details.dart';
import 'package:marvel_app/ui/widgets/mycard.dart';

import '../../constants.dart';
import '../../data/marvel_repository.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Character> characters = MarvelRepository.characters;
  void fetch({int? offest}) async {
    int val = 80;
    if (offest != null) {
      val = offest;
    }
    BlocProvider.of<SearchCubit>(context).emitRefreshing();
    await MarvelRepository.getAllCharacter(offest: val);
    characters = MarvelRepository.characters;
    BlocProvider.of<SearchCubit>(context).emitNotSearching();
  }

  void searchCharacter({required String name}) async {
    BlocProvider.of<SearchCubit>(context).emitSearching();
    await MarvelRepository.searchCharacter(name: name);
    print("search complete");
    characters = MarvelRepository.searchCharacters;
    BlocProvider.of<SearchCubit>(context).emitDoneSearching();
  }

  @override
  void initState() {
    fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _searchController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<SearchCubit, SearchState>(builder: (context, state) {
          return AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            reverseDuration: Duration(microseconds: 200),
            transitionBuilder: (child, animation) {
              var animationOffset = animation
                  .drive(Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0)));

              return SlideTransition(
                position: animationOffset,
                child: child,
              );
            },
            child: state is NotSearching || state is Refreshing
                ? Text("Marvel App")
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
          BlocBuilder<SearchCubit, SearchState>(builder: (context, state) {
            if (!(state is NotSearching || state is Refreshing)) {
              return IconButton(
                  onPressed: () {
                    characters = MarvelRepository.characters;
                    BlocProvider.of<SearchCubit>(context).emitNotSearching();
                  },
                  icon: Icon(Icons.close));
            } else {
              return IconButton(
                  onPressed: () {
                    BlocProvider.of<SearchCubit>(context).emitTyping();
                  },
                  icon: Icon(Icons.search));
            }
          })
        ],
      ),
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DrawerHeader(
              child: Container(
                height: 50,
                child: Image.asset("assets/marvel_logo.png"),
              ),
            ),
            ListTile(
                title: Text("Characters"),
                leading: Icon(
                  Icons.account_circle_rounded,
                )),
            ListTile(
              title: Text("Comics"),
              leading: Icon(
                Icons.menu_book,
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
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
              BlocProvider.of<SearchCubit>(context).emitNotSearching();
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
