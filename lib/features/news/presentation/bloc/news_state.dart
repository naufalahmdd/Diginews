import 'package:equatable/equatable.dart';
import '../../domain/entities/article.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object?> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsSuccess extends NewsState {
  final List<Article> articles;
  final bool isFromCache;

  const NewsSuccess(this.articles, {this.isFromCache = false});

  @override
  List<Object?> get props => [articles, isFromCache];
}

class NewsError extends NewsState {
  final String message;

  const NewsError(this.message);

  @override
  List<Object?> get props => [message];
}