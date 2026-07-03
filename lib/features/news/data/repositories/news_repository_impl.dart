import 'package:dio/dio.dart';
import '../../domain/repositories/news_repository.dart';
import '../models/article_model.dart';

class NewsRepositoryImpl implements NewsRepository {
  final Dio dio;

  NewsRepositoryImpl({required this.dio});

  @override
  Future<List<ArticleModel>> getTopHeadlines() async {
    try {
      const String apiKey = '1a528748064a475fabf04c34d5c40d2e';
      
      final response = await dio.get(
        'top-headlines',
        queryParameters: {
          'country': 'us',
          'apiKey': apiKey,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> articlesJson = response.data['articles'] ?? [];
        
        // 1. Mapping JSON ke bentuk List<ArticleModel>
        List<ArticleModel> newsList = articlesJson
            .map((json) => ArticleModel.fromJson(json))
            .toList();

        // 2. TANTANGAN ANTI-AI DOSEN: NIM BERAKHIRAN GANJIL (3)
        // Urutkan (Sort) data berdasarkan Judul dari Z ke A (Descending)
        newsList.sort((a, b) => b.title.toLowerCase().compareTo(a.title.toLowerCase()));

        return newsList;
      } else {
        throw Exception('Gagal memuat berita');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan jaringan: $e');
    }
  }
}