import 'package:flutter/material.dart';
import 'package:news_app/bloc/get_category_news_bloc.dart';
import 'package:news_app/bloc/get_source_news_bloc.dart';
import 'package:news_app/elements/error_element.dart';
import 'package:news_app/elements/loader_element.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/model/article_response.dart';
import 'package:news_app/model/source.dart';
import 'package:news_app/style/theme.dart' as myStyle;
import 'package:timeago/timeago.dart' as timeago;

import 'news_detail.dart';

class CategoryDetail extends StatefulWidget {
  // final SourceModel source;
  final IconData icon;
  final String category;
  CategoryDetail({Key key, this.category, this.icon}) : super(key: key);
  @override
  _CategoryDetailState createState() => _CategoryDetailState(category, icon);
}

class _CategoryDetailState extends State<CategoryDetail> {
  // final SourceModel source;
  final IconData icon;
  final String category;
  _CategoryDetailState(this.category, this.icon);

  @override
  void initState() {
    super.initState();
    // getSourceNewsBloc..getSourceNewsBloc(source.id);
    getCategoryNewsBloc..getCategoryNewsBloc(category);
  }

  @override
  void dispose() {
    super.dispose();
    // getSourceNewsBloc..drainStream();
    getCategoryNewsBloc..drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          backgroundColor: myStyle.MyColors.mainColor,
          elevation: 0.0,
          title: Text(""),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
            color: myStyle.MyColors.mainColor,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                SizedBox(
                  width: 80.0,
                  height: 80.0,
                  child: Container(
                    child: Icon(
                      icon,
                      size: 48.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  category,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<ArticleResponse>(
              stream: getCategoryNewsBloc.subject.stream,
              builder: (context, AsyncSnapshot<ArticleResponse> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.error != null && snapshot.data.error.length > 0) {
                    return buildErorWidget(snapshot.data.error);
                  }
                  return _buildCategoryNews(snapshot.data);
                } else if (snapshot.hasError) {
                  return buildErorWidget(snapshot.error);
                } else {
                  return buildLoadingWidget();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryNews(ArticleResponse data) {
    List<ArticleModel> articles = data.articles;
    if (articles.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("No Articles"),
          ],
        ),
      );
    } else {
      return ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailNews(
                            article: articles[index],
                          )));
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.grey[200],
                    width: 1.0,
                  ),
                ),
                color: Colors.white,
              ),
              height: 150.0,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    width: MediaQuery.of(context).size.width * 3 / 5,
                    child: Column(
                      children: [
                        Text(
                          articles[index].title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 14.0,
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Row(
                              children: [
                                Text(
                                  timeAgo(
                                    DateTime.parse(articles[index].date),
                                  ),
                                  style: TextStyle(
                                    color: Colors.black26,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 10.0),
                    width: MediaQuery.of(context).size.width * 2 / 5,
                    height: 130.0,
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/img/placeholder.jpg',
                      image: articles[index].img == null ? "https://complianz.io/wp-content/uploads/2019/03/placeholder-300x202.jpg" : articles[index].img,
                      fit: BoxFit.fitHeight,
                      width: double.maxFinite,
                      height: MediaQuery.of(context).size.height * 1 / 3,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  String timeAgo(DateTime date) {
    return timeago.format(date, allowFromNow: true, locale: 'en');
  }
}
