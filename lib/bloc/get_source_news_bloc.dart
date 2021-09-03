import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:news_app/model/article_response.dart';
import 'package:news_app/repository/repository.dart';
import 'package:rxdart/subjects.dart';

class GetSourceNewsBloc {
  final NewsRepository _repository = NewsRepository();
  final BehaviorSubject<ArticleResponse> _subject = BehaviorSubject<ArticleResponse>();

  getSourceNewsBloc(String sourceID) async {
    ArticleResponse response = await _repository.getSourceNews(sourceID);
    _subject.sink.add(response);
  }

  void drainStream() {
    _subject.value = null;
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<ArticleResponse> get subject => _subject;
}

final getSourceNewsBloc = GetSourceNewsBloc();
