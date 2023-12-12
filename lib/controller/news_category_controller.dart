import 'package:news_app/model/news_category_model.dart';
import 'package:news_app/repository/news_category_repository%20.dart';

class NewsCategoryController {
  final _newsCategoryRepository = NewsCategoryRepository();
  Future<NewsCategoryModel> getNewsByCategory(String category) async {
    final response = await _newsCategoryRepository.getNewsByCategory(category);
    return response;
  }
}
