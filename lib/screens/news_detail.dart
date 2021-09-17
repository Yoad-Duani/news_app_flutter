import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/model/favoriteArticle.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:news_app/style/theme.dart' as mystyle;
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:news_app/screens/web_view_screen.dart';
import 'package:news_app/utils/databaseCollections.dart';

class DetailNews extends StatefulWidget {
  final ArticleModel article;
  DetailNews({Key key, @required this.article}) : super(key: key);
  @override
  _DetailNewsState createState() => _DetailNewsState(article);
}

class _DetailNewsState extends State<DetailNews> {
  Future<dynamic> _collectionsFuture;
  Future<dynamic> _favoriteArticlesFuture;
  final ArticleModel article;
  _DetailNewsState(this.article);

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

  newCollection(String collectionName) async {
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
    await DBProvider.db.newFavoriteArticle(favoriteArticle);
  }

  @override
  Widget build(BuildContext context) {
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
          style: TextStyle(fontSize: Theme.of(context).platform == TargetPlatform.iOS ? 17.0 : 17.0, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 21.0),
            child: IconButton(
              onPressed: () {
                // Get.toNamed("/coinDataPage");
              },
              icon: Icon(
                Icons.bookmarks_outlined,
                size: 22.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
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
      ),
    );
  }

  String timeUntil(DateTime date) {
    return timeago.format(date, allowFromNow: true);
  }
}
