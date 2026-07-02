import 'package:equatable/equatable.dart';

/// Domain entity — murni, tidak tahu-menahu soal Isar atau JSON.
class Article extends Equatable {
  final String title;
  final String? author;
  final String? description;
  final String url;
  final String? urlToImage;
  final DateTime publishedAt;
  final String sourceName;

  const Article({
    required this.title,
    this.author,
    this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    required this.sourceName,
  });

  @override
  List<Object?> get props => [url, title, publishedAt];
}