import '../../data/models/article_model.dart';

abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsSuccess extends NewsState {
  final List<ArticleModel> articles;
  NewsSuccess({required this.articles});
}

class NewsError extends NewsState {
  final String message;
  NewsError({required this.message});
}