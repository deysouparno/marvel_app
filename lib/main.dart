import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/cubits/search/search_cubit.dart';
import 'package:marvel_app/cubits/web_progress/cubit/progress_cubit.dart';
import 'package:marvel_app/ui/screens/character_page.dart';
import 'package:marvel_app/ui/screens/comic_page.dart';
import 'package:marvel_app/ui/widgets/drawer_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CharacterPageStateCubit>(
          create: (context) => CharacterPageStateCubit(),
        ),
        BlocProvider<ComicPageStateCubit>(
          create: (context) => ComicPageStateCubit(),
        ),
        BlocProvider<ProgressCubit>(
          create: (context) => ProgressCubit(),
        ),
        BlocProvider<CharacterDetailsCubit>(
          create: (context) => CharacterDetailsCubit(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        darkTheme: ThemeData(
            primaryColor: Color(0xFF964545), brightness: Brightness.dark),
        theme: ThemeData(
          primaryColor: Color(0xFFc75a5a),
          // primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}

bool shouldRefresh = true;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDraging = false;
  bool isDrawerOpen = false;
  DrawerItem item = DrawerItems.characterPage;

  void openDrawer() {
    setState(() {
      xOffset = 230;
      yOffset = 130;
      scaleFactor = 0.6;
      isDrawerOpen = true;
    });
  }

  void closeDrawer() => setState(() {
        xOffset = 0;
        yOffset = 0;
        scaleFactor = 1;
        isDrawerOpen = false;
      });

  Widget buildDrawer() => SafeArea(child: DrawerWidget(
        onItemSelected: (item) {
          setState(() {
            this.item = item;
          });
          print(item.title);
          closeDrawer();
        },
      ));
  Widget buildPage() {
    return WillPopScope(
      onWillPop: () async {
        if (isDrawerOpen) {
          closeDrawer();
          return false;
        } else {
          return true;
        }
      },
      child: GestureDetector(
        onHorizontalDragStart: (details) => isDraging = true,
        onHorizontalDragUpdate: (details) {
          if (!isDraging) {
            return;
          }
          const delta = 1;
          if (details.delta.dx > delta) {
            openDrawer();
          } else if (details.delta.dx < -delta) {
            closeDrawer();
          }
          isDraging = false;
        },
        onTap: closeDrawer,
        child: AnimatedContainer(
            duration: Duration(milliseconds: 250),
            transform: Matrix4.translationValues(xOffset, yOffset, 0)
              ..scale(scaleFactor),
            child: AbsorbPointer(
              absorbing: isDrawerOpen,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(isDrawerOpen ? 20 : 0),
                child: Container(
                  // color: isDrawerOpen
                  //     ? Colors.white12
                  //     : Theme.of(context).primaryColor,
                  // color: Colors.transparent,
                  child: getDrawerPage(),
                ),
              ),
            )),
      ),
    );
  }

  Widget getDrawerPage() {
    switch (item) {
      case DrawerItems.comicsPage:
        if (shouldRefresh) {
          shouldRefresh = false;
          return ComicPage(
            openDrawer: openDrawer,
            shouldRefresh: true,
          );
        }
        return ComicPage(
          openDrawer: openDrawer,
          shouldRefresh: shouldRefresh,
        );
      default:
        if (shouldRefresh) {
          shouldRefresh = false;
          return CharacterPage(
            openDrawer: openDrawer,
            shouldRefresh: true,
          );
        }

        return CharacterPage(
          openDrawer: openDrawer,
          shouldRefresh: shouldRefresh,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Stack(
          children: [buildDrawer(), buildPage()],
        ));
  }
}
