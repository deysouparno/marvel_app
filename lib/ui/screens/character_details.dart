import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/cubits/search/search_cubit.dart';
import 'package:marvel_app/data/character_details_repository.dart';
import 'package:marvel_app/models/character.dart';
import 'package:marvel_app/models/comic.dart';
import 'package:marvel_app/ui/screens/webView_page.dart';
import 'package:marvel_app/ui/widgets/mycard.dart';

import '../../constants.dart';

class CharacterDetails extends StatefulWidget {
  final Character character;
  const CharacterDetails({Key? key, required this.character}) : super(key: key);

  @override
  _CharacterDetailsState createState() => _CharacterDetailsState();
}

class _CharacterDetailsState extends State<CharacterDetails> {
  CharacterDetailsCubit? characterDetailsCubit;
  @override
  void initState() {
    characterDetailsCubit = BlocProvider.of<CharacterDetailsCubit>(context);
    loadComics(context);
    super.initState();
  }

  loadComics(BuildContext context) async {
    characterDetailsCubit?.emitLoading();
    await CharacterDetailsRepo.searchComicsForCharacter(widget.character);
    if (characterDetailsCubit == null) {
      return;
    }
    characterDetailsCubit?.emitLoaded();
    // var x = BlocProvider.of<SearchCubit>(context);
  }

  @override
  void dispose() {
    characterDetailsCubit = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      appBar: AppBar(
        title: Text(widget.character.name),
      ),
      body: SingleChildScrollView(
        // clipBehavior: Clip.none,
        child: Container(
          // height: MediaQuery.of(context).size.height >= 400
          //     ? MediaQuery.of(context).size.height
          //     : 400,
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  if (widget.character.urls.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("character details not found")));
                    return;
                  }

                  String url = widget.character.urls[0].url;
                  widget.character.urls.forEach((element) {
                    if (element.type == "wiki") {
                      url = element.url;
                    }
                  });

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyWebView(
                              url: url.replaceFirst("http", "https"))));
                },
                child: Card(
                  child: Image.network(
                      "${widget.character.thumbnail.path.replaceFirst("http", "https")}/${Constatnts.BEST_QUALITY}${widget.character.thumbnail.extension}"),
                ),
              ),
              widget.character.description == ""
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Text(widget.character.description),
                    )
                  : SizedBox(
                      height: 8.0,
                    ),
              Text(
                "Comics",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline),
              ),
              Container(
                height: 300,
                child: BlocBuilder<CharacterDetailsCubit, SearchState>(
                  builder: (context, state) {
                    if (state is Refreshing) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            CharacterDetailsRepo.comicsForCharacter.length,
                        itemBuilder: (context, index) {
                          Comic comic =
                              CharacterDetailsRepo.comicsForCharacter[index];
                          return Container(
                            width: 220,
                            child: getCard(
                                url:
                                    "${comic.thumbnail.path.replaceFirst("http", "https")}/${Constatnts.BEST_QUALITY}${comic.thumbnail.extension}",
                                text: comic.title),
                          );
                        });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/*

Column(
        children: [
          Image.network(
              "${widget.character.thumbnail.path.replaceFirst("http", "https")}/${Constatnts.BEST_QUALITY}${widget.character.thumbnail.extension}"),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(widget.character.description),
          ),
          Expanded(
            child: Container(
              height: 50,
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is Refreshing) {
                    Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: CharacterDetailsRepo.comicsForCharacter.length,
                      itemBuilder: (context, index) {
                        Comic comic =
                            CharacterDetailsRepo.comicsForCharacter[index];
                        return MyCard(
                            url:
                                "${comic.thumbnail.path.replaceFirst("http", "https")}/${Constatnts.BEST_QUALITY}${comic.thumbnail.extension}",
                            name: comic.title);
                      });
                },
              ),
            ),
          )
        ],
      )

*/
