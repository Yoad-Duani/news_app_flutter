import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/model/favoriteArticle.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:news_app/style/theme.dart' as mystyle;
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:news_app/screens/web_view_screen.dart';
import 'package:news_app/utils/databaseCollections.dart';
import 'dart:async';

class DetailNews extends StatefulWidget {
  final ArticleModel article;
  DetailNews({Key key, @required this.article}) : super(key: key);
  @override
  _DetailNewsState createState() => _DetailNewsState(article);
}

class _DetailNewsState extends State<DetailNews> {
  bool articleInCollection;
  dynamic _collections;
  dynamic _favoriteArticles;
  Future<dynamic> _collectionsFuture;
  Future<dynamic> _favoriteArticlesFuture;
  final ArticleModel article;
  _DetailNewsState(this.article);

  @override
  void initState() {
    super.initState();
    _collectionsFuture = getCollections();
    _favoriteArticlesFuture = getFavoriteArticles();
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

  newFavoriteArticle(String collectionName) {
    var favoriteArticle = FavoriteArticle(
      sourceID: article.source.id,
      sourceName: article.source.name,
      sourceDescription: article.source.description,
      sourceURL: article.source.url,
      sourceCategory: article.source.category,
      sourceCountry: article.source.country,
      sourceLanguage: article.source.language,
      author: article.author,
      title: article.title,
      description: article.description,
      url: article.url,
      img: article.img,
      date: article.date,
      content: article.content,
      collectionName: collectionName,
    );
    DBProvider.db.newFavoriteArticle(favoriteArticle);
  }

  // @override
  // Widget buildA(BuildContext context) {
  //   return StreamBuilder(
  //     stream: DBProvider.db.getFavoriteArticles().asStream(),
  //     builder: (context, snapshot) {
  //
  //       if (!snapshot.hasData) {
  //         print("none");
  //         return LoadingDataWidget();
  //       }  else if (snapshot.hasData) {
  //         print("done");
  //         _collections = snapshot.data[0];
  //         _favoriteArticles = snapshot.data[1];
  //         articleInCollection = checkIsSavedArticle();
  //         return Scaffold()}
  //
  //       print(snapshot.data);
  //       return Container();
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([_collectionsFuture, _favoriteArticlesFuture]),
        builder: (_, snapshot) {
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
            articleInCollection = checkIsSavedArticle();
            return Scaffold(
              bottomNavigationBar: GestureDetector(
                onTap: () {
                  // launch(article.url);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewScreen(article.url, article.title)));
                },
                child: Container(
                  height: 48.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: mystyle.MyColors.mainColor),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Read More",
                        style: TextStyle(color: Colors.white, fontFamily: "SFPro-Bold", fontSize: 15.0),
                      ),
                    ],
                  ),
                ),
              ),
              appBar: AppBar(
                elevation: 0.0,
                backgroundColor: mystyle.MyColors.mainColor,
                title: new Text(
                  article.title,
                  style: TextStyle(fontSize: Theme.of(context).platform == TargetPlatform.iOS ? 13.0 : 13.0, color: Colors.white, fontWeight: FontWeight.bold),
                ),
                actions: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 3.0),
                    child: IconButton(
                      onPressed: () async {
                        if (!articleInCollection) {
                          _addToCollectionsBottomSheet(
                            context,
                          );
                        } else {
                          await DBProvider.db.deleteFavoriteArticle(article.url);
                          _deleteFromCollectionsBottomSheet(context);
                        }
                      },
                      icon: !articleInCollection
                          ? Icon(
                              Icons.bookmarks_outlined,
                              size: 22.0,
                              color: Colors.white,
                            )
                          : Icon(
                              Icons.bookmarks,
                              size: 22,
                              color: Colors.white,
                            ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 3.0),
                    child: IconButton(
                      onPressed: () {
                        // Get.toNamed("/coinDataPage");
                      },
                      icon: Icon(
                        Icons.share,
                        size: 22.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              body: _buildBodyNewsDetail(article),
              // body: FutureBuilder(
              //   future: Future.wait([_collectionsFuture, _favoriteArticlesFuture]),
              //   builder: (_, snapshot) {
              //     // snapshot.data[0]; //collections
              //     // snapshot.data[1]; //favoriteArticles
              //
              //     if (snapshot.connectionState == ConnectionState.none) {
              //       print("none");
              //       return LoadingDataWidget();
              //     } else if (snapshot.connectionState == ConnectionState.waiting) {
              //       print("waiting");
              //       return LoadingDataWidget();
              //     } else if (snapshot.connectionState == ConnectionState.done) {
              //       print("done");
              //       _collections = snapshot.data[0];
              //       _favoriteArticles = snapshot.data[1];
              //       return _buildBodyNewsDetail(article);
              //     }
              //
              //     print("has problem");
              //     return LoadingDataWidget();
              //   },
              // ),

              // _buildBodyNewsDetail(article),
            );
          }

          print("has problem");
          return LoadingDataWidget();
        });
  }

  Widget _buildBodyNewsDetail(ArticleModel article) {
    return ListView(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 16 / 9,
          child: FadeInImage.assetNetwork(
              alignment: Alignment.topCenter,
              placeholder: 'assets/img/loadingPlaceholder.gif',
              image: article.img == null ? "https://archive.org/download/no-photo-available/no-photo-available.png" : article.img,
              fit: BoxFit.cover,
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height * 1 / 3),
        ),
        Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(article.date.substring(0, 10), style: TextStyle(color: mystyle.MyColors.mainColor, fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              GestureDetector(
                onTap: () {},
                child: Text(article.title, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20.0)),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                timeUntil(DateTime.parse(article.date)),
                style: TextStyle(color: Colors.grey, fontSize: 12.0),
              ),
              SizedBox(
                height: 5.0,
              ),
              Html(
                data: article.content == null ? "Press 'Read More' for more details" : article.content,
                style: {
                  "body": Style(
                    fontSize: FontSize(14.0),
                    color: Colors.black87,
                  ),
                  "html": Style(whiteSpace: WhiteSpace.PRE),
                },
              ),
            ],
          ),
        )
      ],
    );
  }

  void _addToCollectionsBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height * 0.65,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Add to",
                        style: TextStyle(fontSize: 16.0),
                      ),
                      InkWell(
                        onTap: () {
                          print("ok");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50.0),
                            ),
                            border: Border.all(
                              color: Colors.grey[400],
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Row(
                              children: [
                                Text(
                                  "New",
                                  style: TextStyle(color: mystyle.MyColors.mainColor, fontSize: 14.0),
                                ),
                                Icon(
                                  Icons.add,
                                  color: mystyle.MyColors.mainColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 18.0,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: _collections.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: GestureDetector(
                          onTap: () async {
                            try {
                              await newFavoriteArticle(_collections[index]["collectionName"]);
                              print("new FavoriteArticle Succeeded");

                              // await update();
                              // setState(() {
                              //   // articleInCollection = true;
                              //   _collectionsFuture = getCollections();
                              //   _favoriteArticlesFuture = getFavoriteArticles();
                              // });
                              Navigator.of(context).pop();
                            } catch (e) {
                              print("new FavoriteArticle Fails");
                            }
                          },
                          child: Container(
                            // padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                            height: 60,
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  // padding: EdgeInsets.only(right: 10.0),
                                  // width: MediaQuery.of(context).size.width * 2 / 7,
                                  width: 60.0,
                                  height: 60.0,
                                  // height: 130.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
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
                                Text(
                                  _collections[index]["collectionName"],
                                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _deleteFromCollectionsBottomSheet(context) {
    Timer _timer;
    _timer = new Timer(const Duration(seconds: 3, milliseconds: 50), () {
      Navigator.of(context).pop();

      // setState(() {
      // });
    });

    // update();

    // setState(() {
    //   // articleInCollection = false;
    //   _collectionsFuture = getCollections();
    //   _favoriteArticlesFuture = getFavoriteArticles();
    //   // articleInCollection = false;
    // });

    showModalBottomSheet(
        // clipBehavior: Clip.none,
        // elevation: 0.0
        // ,
        barrierColor: Colors.white.withOpacity(0),
        context: context,
        builder: (BuildContext bc) {
          return Container(
            color: Colors.black,
            height: 50.0,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Removed",
                  style: TextStyle(color: Colors.white60),
                ),
              ),
            ),
          );
        });
  }

  bool checkIsSavedArticle() {
    for (var favoriteArticle in _favoriteArticles) {
      if (favoriteArticle["url"] == article.url) {
        print("checkIsSavedArticle -- true");
        return true;
      }
    }
    print("checkIsSavedArticle -- false");
    return false;
  }

  update() async {
    try {
      _collections = await getCollections();
      _favoriteArticles = await getFavoriteArticles();
      print("update Collections Succeeded");
    } catch (e) {
      print(e);
    }
  }

  String timeUntil(DateTime date) {
    return timeago.format(date, allowFromNow: true);
  }
}

class LoadingDataWidget extends StatelessWidget {
  const LoadingDataWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
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
