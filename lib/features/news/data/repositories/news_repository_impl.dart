import 'package:dio/dio.dart';
import 'package:isar/isar.dart';
import '../../domain/repositories/news_repository.dart';
import '../models/article_model.dart';
import '../models/article_isar.dart';

class NewsRepositoryImpl implements NewsRepository {
  final Dio dio;
  final Isar isar;

  NewsRepositoryImpl({required this.dio, required this.isar});

  @override
  Future<List<ArticleModel>> getTopHeadlines() async {
    try {
      const String apiKey = '1a528748064a475fabf04c34d5c40d2e';
      
      // Ambil data secara online
      final response = await dio.get(
        'everything',
        queryParameters: {
          'q': 'indonesia',
          'pageSize': 20,
          'apiKey': apiKey,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> articlesJson = response.data['articles'] ?? [];
        
        List<ArticleModel> newsList = articlesJson
            .map((json) => ArticleModel.fromJson(json))
            .toList();

        // SIMPAN KE ISAR (Caching)
        await isar.writeTxn(() async {
          // Bersihkan cache lama terlebih dahulu
          await isar.articleIsars.clear();
          
          // Masukkan data baru ke local database
          for (var article in newsList) {
            final isarArticle = ArticleIsar()
              ..title = article.title
              ..description = article.description
              ..urlToImage = article.urlToImage
              ..author = article.author;
            await isar.articleIsars.put(isarArticle);
          }
        });

        // Urutkan Z-A (NIM Ganjil)
        newsList.sort((a, b) => b.title.toLowerCase().compareTo(a.title.toLowerCase()));
        return newsList;
      } else {
        throw Exception();
      }
    } catch (e) {
      final localArticles = await isar.articleIsars.where().findAll();
      
      if (localArticles.isNotEmpty) {
        List<ArticleModel> offlineList = localArticles.map((isarData) {
          return ArticleModel(
            title: isarData.title,
            description: isarData.description,
            urlToImage: isarData.urlToImage,
            author: isarData.author,
          );
        }).toList();

        // Tetap urutkan Z-A walaupun offline
        offlineList.sort((a, b) => b.title.toLowerCase().compareTo(a.title.toLowerCase()));
        return offlineList;
      }
      
      throw Exception('Tidak ada koneksi internet & cache lokal kosong.');
    }
  }
}