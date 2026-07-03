import '../../data/models/article_model.dart';

abstract class NewsRepository {
  Future<List<ArticleModel>> getTopHeadlines();
}