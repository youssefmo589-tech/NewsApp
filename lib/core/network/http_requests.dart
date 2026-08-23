import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/Modules/Articleclass.dart';
import 'package:news/Modules/source_model.dart';
import 'package:news/core/AppRoutes/Constant/app_Constant.dart';
import 'package:news/core/network/endpoints.dart';

class HttpRequestService {
  static Future<List<Source>> getAllSources(
    String categoryid,) async {
    final Map<String, String> QueryParameters = {
      "apiKey": AppConstants.ApiKey,
      "category": categoryid,
    };
    final response = await http.get(
      Uri.https(
        AppConstants.baseUrl,
        EndPoints.AllSources,
        QueryParameters,
      ),
    );

    final decodedata = jsonDecode(response.body);

    final data = SourceModel.fromjson(decodedata);

    return data.sources;
  }

  static Future<List<Article>> getAllArticles(
    String sourceID,
    int page,
    int pagesize,
  ) async {
    final Map<String, String> QueryParameters = {
      "apiKey": AppConstants.ApiKey,
      "sources": sourceID,
      "page": page.toString(),
      "pagesize": pagesize.toString(),
    };
    final response = await http.get(
      Uri.https(
        AppConstants.baseUrl,
        EndPoints.AllArticle,
        QueryParameters,
      ),
    );

    List<Article> articles = [];

    final decodedata = jsonDecode(response.body);

    for (var article in decodedata["articles"]) {
      final data = Article.fromjson(article);
      articles.add(data);
    }
    return articles;
  }
}
