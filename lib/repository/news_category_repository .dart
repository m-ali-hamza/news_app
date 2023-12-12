import 'dart:convert';
import 'package:news_app/model/news_category_model.dart';
import 'package:http/http.dart' as http;

class NewsCategoryRepository {
  Future<NewsCategoryModel> getNewsByCategory(String category) async {
    String url =
        "https://newsapi.org/v2/everything?q=$category&apiKey=0490cab6b3154962a6de62c40415538e";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      return NewsCategoryModel.fromJson(body);
    }
    throw Exception();
  }
}
