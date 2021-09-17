import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_app/utils/databaseCollections.dart';
import 'package:news_app/utils/databaseFavoriteArticles.dart';
import 'package:news_app/utils/databaseCollections.dart';
import 'package:news_app/style/theme.dart' as myStyle;

class CollectionsScreen extends StatefulWidget {
  @override
  _CollectionsScreenState createState() => _CollectionsScreenState();
}

class _CollectionsScreenState extends State<CollectionsScreen> {
  Future<dynamic> _collectionsFuture;
  Future<dynamic> _favoriteArticlesFuture;
  dynamic collections;

  @override
  void initState() {
    super.initState();
    // DBProvider.db.initDB();
    _collectionsFuture = getCollections();
    _favoriteArticlesFuture = getFavoriteArticles();
    //getSourceNewsBloc..getSourceNewsBloc(source.id);
  }

  @override
  void dispose() {
    super.dispose();
    // getSourceNewsBloc..drainStream();
  }

  getCollections() async {
    final _collectionData = await DBProvider.db.getCollection();
    return _collectionData;
  }

  getFavoriteArticles() async {
    final _collectionData = await DBProvider.db.getFavoriteArticles();
    return _collectionData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Future.wait([_collectionsFuture, _favoriteArticlesFuture]),
        builder: (_, snapshot) {
          // snapshot.data[0]; //collections
          // snapshot.data[1]; //favoriteArticles

          if (snapshot.connectionState == ConnectionState.none) {
            print("none");
            return LoadingDataWidget();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            print("waiting");
            return LoadingDataWidget();
          } else if (snapshot.connectionState == ConnectionState.done) {
            print("done");
            return _buildCollectionsScreen(snapshot.data);
          }

          print("has problem");
          return LoadingDataWidget();
        },
      ),
    );
  }

  Widget _buildCollectionsScreen(dynamic data) {
    print(data[0]);
    print(data[1]);
    print(data);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0, left: 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "My Collections",
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                ),
                InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      Text("New"),
                      Icon(
                        Icons.add,
                        color: myStyle.MyColors.mainColor,
                        size: 36,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 3.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Recently added items",
                style: TextStyle(color: Colors.grey[500]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LoadingDataWidget extends StatelessWidget {
  const LoadingDataWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Loading...',
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 20.0),
          SpinKitRing(
            color: Colors.grey[700],
            size: 60.0,
          ),
        ],
      ),
    );
  }
}
