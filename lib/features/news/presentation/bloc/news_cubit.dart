import 'package:diginews/features/news/domain/usecase/get_top_headline.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final GetTopHeadlines getTopHeadlines;

  NewsCubit(this.getTopHeadlines) : super(NewsInitial());

  Future<void> loadNews() async {
    emit(NewsLoading());
    try {
      final articles = await getTopHeadlines();
      if (articles.isEmpty) {
        emit(const NewsError('Tidak ada data. Cek koneksi internet Anda.'));
      } else {
        emit(NewsSuccess(articles));
      }
    } catch (e) {
      emit(NewsError('Gagal memuat berita: $e'));
    }
  }
}