import 'package:news_app/model/news_headlines_model.dart';
import 'package:news_app/repository/news_headlines_repository.dart';

class NewsHeadlinesController {
  final _newsHeadlinesRepository = NewsHeadlinesRepository();
  Future<NewsHeadlinesModel> getNewsHeadlines(String channelName) async {
    final response =
        await _newsHeadlinesRepository.getNewsHeadlines(channelName);
    return response;
  }
}
