import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/Modules/Articleclass.dart';
import 'package:news/Modules/source_model.dart';
import 'package:news/core/AppRoutes/Constant/app_Constant.dart';
import 'package:news/core/network/endpoints.dart';

class HttpRequestService {
  static Future<List<Source>> getAllSources(
    String categoryid,
  ) // traga3 masader elakhbarrr
  async {
    // tool to n get data aw to fetch data from network   hnstakhdem package esmaha Http

    final Map<String, String> QueryParameters = {
      "apiKey": AppConstants.ApiKey,
      "category": categoryid,
    };
    final response = await http.get(
      Uri.https(
        AppConstants.baseUrl, // domain
        EndPoints.AllSources, //endpoint
        QueryParameters,
      ),
    );

    final decodedata = jsonDecode(response.body);

    final data = SourceModel.fromjson(decodedata);

    return data.sources;
  }

  static Future<List<Article>> getAllArticles(String sourceID) async {
    final Map<String, String> QueryParameters = {
      "apiKey": AppConstants.ApiKey,
      "sources": sourceID,
    };
    final response = await http.get(
      Uri.https(
        AppConstants.baseUrl, // domain
        EndPoints.AllArticle, //endpoint
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
