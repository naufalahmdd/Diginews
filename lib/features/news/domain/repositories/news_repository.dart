import '../entities/article.dart';

/// Kontrak (interface). Implementasinya ada di data layer.
/// Domain layer TIDAK BOLEH tahu soal Dio, Isar, dsb — inilah inti Clean Architecture.
abstract class NewsRepository {
  /// Mengambil berita. Jika online -> fetch API, cache ke Isar, lalu return.
  /// Jika offline -> ambil dari cache Isar terakhir.
  /// Sorting (berdasarkan digit terakhir NIM) SUDAH dilakukan di sini,
  /// sebelum data ini nyampe ke BLoC/Cubit.
  Future<List<Article>> getTopHeadlines();
}