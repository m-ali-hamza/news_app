import 'dart:convert';

import 'package:news_app/model/news_headlines_model.dart';
import 'package:http/http.dart' as http;

class NewsHeadlinesRepository {
  Future<NewsHeadlinesModel> getNewsHeadlines() async {
    String url =
        "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=0490cab6b3154962a6de62c40415538e";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      print(body);
      return NewsHeadlinesModel.fromJson(body);
    }
    throw Exception();
  }
}
