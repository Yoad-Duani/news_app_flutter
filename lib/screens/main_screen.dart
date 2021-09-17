import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:news_app/bloc/botton_navbar_bloc.dart';
import 'package:news_app/screens/tabs/home_screen.dart';
import 'package:news_app/style/theme.dart' as Style;
import 'package:news_app/screens/tabs/source_screen.dart';
import 'package:news_app/screens/tabs/search_screen.dart';
import 'package:news_app/utils/databaseCollections.dart' as myDB;
import 'package:news_app/screens/tabs/collections_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  BottomNavBarBloc _bottomNavBarBloc;
  // Future<dynamic> _collectionFuture;
  dynamic collections;

  @override
  void initState() {
    super.initState();

    _bottomNavBarBloc = BottomNavBarBloc();
    // _collectionFuture = getCollections();
  }

  // getCollections() async {
  //   final _collectionData = await myDB.DBProvider.db.getCollection();
  //   //print(_collectionData);
  //   return _collectionData;
  // }

  // printDataTest() async {
  //   FutureBuilder(
  //     future: _collectionFuture,
  //     builder: (_, collectionData) {
  //       switch (collectionData.connectionState) {
  //         case ConnectionState.none:
  //           print("none");
  //           return Text("none");
  //         case ConnectionState.waiting:
  //           print("waiting");
  //           return Text("waiting");
  //         case ConnectionState.done:
  //           print('done 111');
  //           {
  //             collections = collectionData.data;
  //             print(collections);
  //             return Text("done");
  //           }
  //         default:
  //           return Text("problem");
  //       }
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: Style.MyColors.mainColor,
          title: Center(
            child: Text(
              "NewsApp",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: StreamBuilder<NavBarItem>(
            stream: _bottomNavBarBloc.itemStream,
            initialData: _bottomNavBarBloc.defaultItem,
            builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
              switch (snapshot.data) {
                case NavBarItem.HOME:
                  return HomeScreen();
                case NavBarItem.SOURCES:
                  return SourceScreen();
                case NavBarItem.SEARCH:
                  return SearchScreen();
                case NavBarItem.BOOKMARKS:
                  return CollectionsScreen();
                default:
                  return Container();
              }
            }),
      ),
      bottomNavigationBar: StreamBuilder(
        stream: _bottomNavBarBloc.itemStream,
        initialData: _bottomNavBarBloc.defaultItem,
        builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              boxShadow: [
                BoxShadow(color: Colors.grey[100], spreadRadius: 0, blurRadius: 10.0),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                iconSize: 20.0,
                unselectedItemColor: Style.MyColors.grey,
                unselectedFontSize: 9.5,
                selectedFontSize: 10.0,
                type: BottomNavigationBarType.fixed,
                fixedColor: Style.MyColors.mainColor,
                currentIndex: snapshot.data.index,
                onTap: _bottomNavBarBloc.pickItem,
                items: [
                  BottomNavigationBarItem(label: "Home", icon: Icon(EvaIcons.homeOutline), activeIcon: Icon(EvaIcons.home)),
                  BottomNavigationBarItem(label: "Sources", icon: Icon(EvaIcons.gridOutline), activeIcon: Icon(EvaIcons.grid)),
                  BottomNavigationBarItem(label: "Search", icon: Icon(EvaIcons.searchOutline), activeIcon: Icon(EvaIcons.search)),
                  BottomNavigationBarItem(label: "Collections", icon: Icon(Icons.bookmarks_outlined), activeIcon: Icon(Icons.bookmarks)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget testScreen() {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Text("Test Screen")],
      ),
    );
  }
}
