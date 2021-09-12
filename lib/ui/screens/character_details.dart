import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/cubits/cubit/search_cubit.dart';
import 'package:marvel_app/data/character_details_repository.dart';
import 'package:marvel_app/models/character.dart';
import 'package:marvel_app/models/comic.dart';
import 'package:marvel_app/ui/widgets/mycard.dart';

import '../../constants.dart';

class CharacterDetails extends StatefulWidget {
  final Character character;
  const CharacterDetails({Key? key, required this.character}) : super(key: key);

  @override
  _CharacterDetailsState createState() => _CharacterDetailsState();
}

class _CharacterDetailsState extends State<CharacterDetails> {
  @override
  void initState() {
    loadComics(context);
    super.initState();
  }

  loadComics(BuildContext context) async {
    BlocProvider.of<SearchCubit>(context).emitRefreshing();
    await CharacterDetailsRepo.searchComicsForCharacter(widget.character);
    BlocProvider.of<SearchCubit>(context).emitNotSearching();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.character.name),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Image.network(
                  "${widget.character.thumbnail.path.replaceFirst("http", "https")}/${Constatnts.BEST_QUALITY}${widget.character.thumbnail.extension}"),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(widget.character.description),
              ),
              Expanded(
                // height: 250,
                // width: MediaQuery.of(context).size.width,
                child: BlocBuilder<SearchCubit, SearchState>(
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
                            color: Colors.red,
                            width: 250,
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
