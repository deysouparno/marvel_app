import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:marvel_app/cubits/search/search_cubit.dart';
import 'package:marvel_app/data/marvel_repository.dart';
import 'package:marvel_app/models/comic.dart';
import 'package:marvel_app/ui/screens/webView_page.dart';
import 'package:marvel_app/ui/widgets/mycard.dart';

import '../../constants.dart';

class ComicPage extends StatefulWidget {
  final bool shouldRefresh;
  const ComicPage({
    Key? key,
    required this.shouldRefresh,
    required this.openDrawer,
  }) : super(key: key);
  final VoidCallback openDrawer;

  @override
  _ComicPageState createState() => _ComicPageState();
}

class _ComicPageState extends State<ComicPage> {
  List<Comic> comics = MarvelRepository.comics;
  ComicPageStateCubit? comicPageStateCubit;
  void fetch({int? offest}) async {
    int val = Random().nextInt(1500);
    if (offest != null) {
      val = offest;
    }
    comicPageStateCubit?.emitRefreshing();

    await MarvelRepository.getAllComics(offest: val);
    comics = MarvelRepository.comics;

    comicPageStateCubit?.emitNotSearching();
  }

  void searchComic({required String name}) async {
    comicPageStateCubit?.emitSearching();
    await MarvelRepository.searchComic(name: name);
    print("search complete");
    comics = MarvelRepository.comics;
    comicPageStateCubit?.emitDoneSearching();
  }

  @override
  void initState() {
    comicPageStateCubit = BlocProvider.of<ComicPageStateCubit>(context);
    fetch();
    super.initState();
  }

  @override
  void dispose() {
    comicPageStateCubit = null;
    super.dispose();
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
        title: BlocBuilder<ComicPageStateCubit, SearchState>(
            builder: (context, state) {
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
                ? Text("Comics")
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
                            searchComic(name: _searchController.text);
                          },
                          child: Text("Search"))
                    ],
                  ),
          );
        }),
        actions: [
          BlocBuilder<ComicPageStateCubit, SearchState>(
              builder: (context, state) {
            if (!(state is NotSearching || state is Refreshing)) {
              return IconButton(
                  onPressed: () {
                    comics = MarvelRepository.comics;
                    comicPageStateCubit?.emitNotSearching();
                  },
                  icon: Icon(Icons.close));
            } else {
              return IconButton(
                  onPressed: () {
                    comicPageStateCubit?.emitTyping();
                  },
                  icon: Icon(Icons.search));
            }
          })
        ],
      ),
      body: BlocBuilder<ComicPageStateCubit, SearchState>(
        builder: (context, state) {
          if (state is Searching || state is Refreshing) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          print("comic loading");
          return RefreshIndicator(
            onRefresh: () async {
              await MarvelRepository.getAllComics(
                  offest: Random().nextInt(1500));
              comics = MarvelRepository.comics;
              comicPageStateCubit?.emitNotSearching();
            },
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: comics.length,
                itemBuilder: (context, index) {
                  Comic comic = comics[index];
                  return GestureDetector(
                    onTap: () {
                      if (comic.urls.length == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Comic not found")));
                        return;
                      }
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MyWebView(
                              url: comic.urls[0].url
                                  .replaceFirst("http", "https"))));
                    },
                    child: Container(
                      height: 200,
                      width: 200,
                      child: getCard(
                          url:
                              "${comic.thumbnail.path.replaceFirst("http", "https")}/${Constatnts.BEST_QUALITY}${comic.thumbnail.extension}",
                          text: comic.title),
                    ),
                  );
                }),
          );
        },
      ),
    );
  }
}
