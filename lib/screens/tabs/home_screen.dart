import 'package:flutter/material.dart';
import 'package:news_app/widgets/headline_slider.dart';
import 'package:news_app/widgets/top_channels.dart';
import 'package:news_app/widgets/hot_news.dart';
import 'package:news_app/style/theme.dart' as mystyle;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        HeadlineSliderWidget(),
        SizedBox(height: 10.0),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "Top channels",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
        ),
        TopChannels(),
        SizedBox(height: 10.0),
        Padding(
          padding: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0, bottom: 10.0),
          child: Text(
            "Hot news",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
        ),
        HotNews(),
      ],
    );
  }
}
