import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../../features/news/data/repositories/news_repository_impl.dart';
import '../../features/news/domain/repositories/news_repository.dart';
import '../../features/news/presentation/bloc/news_bloc.dart';

// sl singkatan dari Service Locator
final sl = GetIt.instance;

Future<void> init() async {

  sl.registerFactory(() => NewsBloc(newsRepository: sl()));

  sl.registerLazySingleton<NewsRepository>(() => NewsRepositoryImpl(dio: sl()));
  
  // Daftarkan Dio sebagai Singleton (hanya ada 1 instance di seluruh aplikasi)
  sl.registerLazySingleton<Dio>(() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/v2/', // Base URL API berita
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    // TANTANGAN: Dosen meminta menggunakan Interceptor
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
    );

    return dio;
  });

  // ==========================================
  // 2. FEATURES (News & Profile)
  // ==========================================
  // Nanti setelah kita buat Repository dan BLoC, kita daftarkan di sini bawah ini.
}