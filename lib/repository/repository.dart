import 'package:dio/dio.dart';
import 'package:news_app/model/article_response.dart';
import 'package:news_app/model/source_response.dart';

class NewsRepository {
  static String mainURL = "https://newsapi.org/v2/";
  final String apikey = "509ea7c380274d5b9ae18c7a3fe9af7c";

  final Dio _dio = Dio();

  var getSourcesUrl = "$mainURL/sources";
  var getTopHeadLinesUrl = "$mainURL/top-headlines";
  var everythingUrl = "$mainURL/everything";

  Future<SourceResponse> getSources() async {
    var params = {"apiKey": apikey, "language": "en"};
    try {
      Response response = await _dio.get(getSourcesUrl, queryParameters: params);
      return SourceResponse.fromJson(response.data);
    } catch (e, stacktrance) {
      print("excption occured: ${e.toString()} stackTrance: $stacktrance");
      return SourceResponse.withError(e.toString());
    }
  }

  Future<ArticleResponse> getTopHeadlines() async {
    var params = {"apiKey": apikey, "country": "us"};
    try {
      Response response = await _dio.get(getTopHeadLinesUrl, queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    } catch (e) {
      return ArticleResponse.withError(e.toString());
    }
  }

  Future<ArticleResponse> getHotNews() async {
    var params = {"apiKey": apikey, "q": "apple", "sortBy": "popularity"};
    try {
      Response response = await _dio.get(everythingUrl, queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    } catch (e) {
      return ArticleResponse.withError(e.toString());
    }
  }

  Future<ArticleResponse> getSourceNews(String sourceID) async {
    var params = {"apiKey": apikey, "sources": sourceID};
    try {
      Response response = await _dio.get(getTopHeadLinesUrl, queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    } catch (e) {
      return ArticleResponse.withError(e.toString());
    }
  }

  Future<ArticleResponse> getCategoryNews(String category) async {
    var params = {"apiKey": apikey, "category": category, "language": "en", "sortBy": "popularity"};
    //, "country": "gb"
    try {
      getTopHeadLinesUrl = getTopHeadLinesUrl;
      Response response = await _dio.get(getTopHeadLinesUrl, queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    } catch (e) {
      return ArticleResponse.withError(e.toString());
    }
  }

  Future<ArticleResponse> search(String searchValue) async {
    var params = {"apiKey": apikey, "q": searchValue};
    try {
      everythingUrl = everythingUrl;
      Response response = await _dio.get(everythingUrl, queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    } catch (e) {
      return ArticleResponse.withError(e.toString());
    }
  }
}
