import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../features/news/data/models/article_isar.dart';
import '../../features/news/data/repositories/news_repository_impl.dart';
import '../../features/news/domain/repositories/news_repository.dart';
import '../../features/news/presentation/bloc/news_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // 1. Inisialisasi Isar Database
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open([ArticleIsarSchema], directory: dir.path);
  sl.registerSingleton<Isar>(isar);

  // 2. FEATURES
  sl.registerFactory(() => NewsBloc(newsRepository: sl()));
  sl.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImpl(dio: sl(), isar: sl()),
  );

  // 3. CORE / EXTERNAL
  sl.registerLazySingleton<Dio>(() {
    final dio = Dio(BaseOptions(baseUrl: 'https://newsapi.org/v2/'));
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    return dio;
  });
}
