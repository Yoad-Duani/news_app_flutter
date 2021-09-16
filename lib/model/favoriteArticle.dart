import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:news_app/model/source.dart';

FavoriteArticle favoriteArticleFromJson(String str) => FavoriteArticle.fromJson(json.decode(str));
String favoriteArticleToJson(FavoriteArticle data) => json.encode(data.toJson());

class FavoriteArticle {
  SourceModel source;
  String author;
  String title;
  String description;
  String url;
  String img;
  String date;
  String content;

  FavoriteArticle({this.source, this.author, this.title, this.description, this.url, this.img, this.date, this.content});

  factory FavoriteArticle.fromJson(Map<String, dynamic> json) => FavoriteArticle(
        source: json["source"],
        author: json['author'],
        title: json['title'],
        description: json["description"],
        url: json['url'],
        img: json['img'],
        date: json['date'],
        content: json['content'],
      );

  Map<String, dynamic> toJson() => {
        'source': source,
        'author': author,
        'title': title,
        'description': description,
        'url': url,
        'img': img,
        'date': date,
        'content': content,
      };
}
