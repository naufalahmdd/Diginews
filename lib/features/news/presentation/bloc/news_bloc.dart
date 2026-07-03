import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/news_repository.dart';
import 'news_event.dart';
import 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository newsRepository;

  NewsBloc({required this.newsRepository}) : super(NewsInitial()) {
    // Menangani Event FetchTopHeadlines
    on<FetchTopHeadlines>((event, emit) async {
      emit(NewsLoading());
      try {
        // Mengambil data dari repository (Sudah otomatis ter-sort Z-A)
        final articles = await newsRepository.getTopHeadlines();
        emit(NewsSuccess(articles: articles));
      } catch (e) {
        emit(NewsError(message: e.toString()));
      }
    });
  }
}