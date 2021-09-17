import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:news_app/model/source.dart';

FavoriteArticle favoriteArticleFromJson(String str) => FavoriteArticle.fromJson(json.decode(str));
String favoriteArticleToJson(FavoriteArticle data) => json.encode(data.toJson());

class FavoriteArticle {
  // SourceModel source;
  String sourceID;
  String sourceName;
  String sourceDescription;
  String sourceURL;
  String sourceCategory;
  String sourceCountry;
  String sourceLanguage;
  String author;
  String title;
  String description;
  String url;
  String img;
  String date;
  String content;
  String collectionName;

  FavoriteArticle(
      {this.sourceID,
      this.sourceName,
      this.sourceDescription,
      this.sourceURL,
      this.sourceCategory,
      this.sourceCountry,
      this.sourceLanguage,
      this.author,
      this.title,
      this.description,
      this.url,
      this.img,
      this.date,
      this.content,
      this.collectionName});

  factory FavoriteArticle.fromJson(Map<String, dynamic> json) => FavoriteArticle(
        sourceID: json['sourceID'],
        sourceName: json['sourceName'],
        sourceDescription: json["sourceDescription"],
        sourceURL: json['sourceURL'],
        sourceCategory: json['sourceCategory'],
        sourceCountry: json['sourceCountry'],
        sourceLanguage: json['sourceLanguage'],
        author: json['author'],
        title: json['title'],
        description: json["description"],
        url: json['url'],
        img: json['img'],
        date: json['date'],
        content: json['content'],
        collectionName: json['collectionName'],
      );

  Map<String, dynamic> toJson() => {
        'sourceID': sourceID,
        'sourceName': sourceName,
        'sourceDescription': sourceDescription,
        'sourceURL': sourceURL,
        'sourceCategory': sourceCategory,
        'sourceCountry': sourceCountry,
        'sourceLanguage': sourceLanguage,
        'author': author,
        'title': title,
        'description': description,
        'url': url,
        'img': img,
        'date': date,
        'content': content,
        'collectionName': collectionName,
      };
}
