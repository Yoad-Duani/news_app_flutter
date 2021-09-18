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
  dynamic _collections;
  dynamic _favoriteArticles;
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
            _collections = snapshot.data[0];
            _favoriteArticles = snapshot.data[1];
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
      padding: const EdgeInsets.only(
        top: 8.0,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0, left: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "My Collections",
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      "Recently added items",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
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
                ),
              ],
            ),
          ),
          SizedBox(
            height: 14.0,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     Text(
          //       "Recently added items",
          //       style: TextStyle(color: Colors.grey[500]),
          //     ),
          //   ],
          // ),
          Container(
            height: 170,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  child: Container(
                    decoration: BoxDecoration(
                      // color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      border: Border.all(
                        color: Colors.grey[300],
                      ),
                    ),
                    // color: Colors.red,
                    // height: 20.0,
                    width: 145.0,
                    child: Column(
                      children: [
                        Container(
                          width: 145.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(7.0),
                              topRight: Radius.circular(7.0),
                            ),
                            image: DecorationImage(
                              image: AssetImage('assets/img/placeholder.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            "Article title  ppppp pppppppppp",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(Icons.more_vert),
                              onPressed: () {},
                              color: Colors.black54,
                            ),
                            Flexible(
                                child: Text(
                              "dep.comkkkkkkkkkkkkkkkkk",
                              overflow: TextOverflow.ellipsis,
                            ))
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          ListView.builder(
              padding: EdgeInsets.only(right: 12.0, left: 13.0),
              shrinkWrap: true,
              itemCount: _collections.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      // color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      border: Border.all(
                        color: Colors.grey[300],
                      ),
                    ),
                    height: 75.0,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Container(
                          // padding: EdgeInsets.only(right: 10.0),
                          // width: MediaQuery.of(context).size.width * 2 / 7,
                          width: 75.0,
                          height: 75.0,
                          // height: 130.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(7.0),
                              bottomLeft: Radius.circular(7.0),
                            ),
                            image: DecorationImage(
                              image: AssetImage('assets/img/placeholder.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          // child: FadeInImage.assetNetwork(
                          //   placeholder: 'assets/img/placeholder.jpg',
                          //   image: articles[index].img == null ? "https://complianz.io/wp-content/uploads/2019/03/placeholder-300x202.jpg" : articles[index].img,
                          //   fit: BoxFit.fitHeight,
                          //   width: double.maxFinite,
                          //   height: MediaQuery.of(context).size.height * 1 / 3,
                          // ),
                        ),
                        SizedBox(
                          width: 12.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _collections[index]["collectionName"],
                              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 2.0,
                            ),
                            Text(
                              "date",
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
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
