import '../entities/article.dart';
import '../repositories/news_repository.dart';

/// Use case = satu "aksi bisnis". BLoC/Cubit memanggil ini, bukan repository langsung,
/// supaya presentation layer tetap tidak tahu detail implementasi data layer.
class GetTopHeadlines {
  final NewsRepository repository;

  GetTopHeadlines(this.repository);

  Future<List<Article>> call() {
    return repository.getTopHeadlines();
  }
}