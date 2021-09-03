import 'package:dio/dio.dart';
import 'package:news_app/model/article_response.dart';
import 'package:news_app/model/source_response.dart';

class NewsRepository {
  static String mainURL = "https://newsapi.org/v2/";
  final String apikey = "my api key";

  final Dio _dio = Dio();

  var getSourcesUrl = "$mainURL/sources";
  var getTopHeadLinesUrl = "$mainURL/top-headlines";
  var everythingUrl = "$mainURL/everything";

  Future<SourceResponse> getSources() async {
    var params = {"apiKey": apikey, "language": "en", "country": "us"};
    try {
      Response response = await _dio.get(getSourcesUrl, queryParameters: params);
      return SourceResponse.fromJson(response.data);
    } catch (e, stacktrance) {
      print("excption occured: $e stackTrance: $stacktrance");
      return SourceResponse.withError(e);
    }
  }

  Future<ArticleResponse> getTopHeadlines() async {
    var params = {"apiKey": apikey, "country": "us"};
    try {
      Response response = await _dio.get(getTopHeadLinesUrl, queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    } catch (e) {
      return ArticleResponse.withError(e);
    }
  }

  //todo: change the apple
  Future<ArticleResponse> getHotNews() async {
    var params = {"apiKey": apikey, "q": "apple", "sortBy": "popularity"};
    try {
      Response response = await _dio.get(everythingUrl, queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    } catch (e) {
      return ArticleResponse.withError(e);
    }
  }

  Future<ArticleResponse> getSourceNews(String sourceID) async {
    var params = {"apiKey": apikey, "sources": sourceID};
    try {
      Response response = await _dio.get(getTopHeadLinesUrl, queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    } catch (e) {
      return ArticleResponse.withError(e);
    }
  }

  Future<ArticleResponse> search(String searchValue) async {
    var params = {"apiKey": apikey, "q": searchValue};
    try {
      Response response = await _dio.get(getTopHeadLinesUrl, queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    } catch (e) {
      return ArticleResponse.withError(e);
    }
  }
}
