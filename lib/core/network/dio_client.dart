import 'package:dio/dio.dart';
import '../constants/app_constant.dart';

/// Interceptor custom: nempelin API key otomatis + logging ringkas.
/// Wajib disebut soal ("Gunakan Dio dengan Interceptor").
class ApiKeyInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'apiKey': AppConstants.newsApiKey,
    });
    // ignore: avoid_print
    print('[Dio] --> ${options.method} ${options.uri}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // ignore: avoid_print
    print('[Dio] <-- ${response.statusCode} ${response.requestOptions.uri}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // ignore: avoid_print
    print('[Dio] xxx ERROR ${err.requestOptions.uri}: ${err.message}');
    handler.next(err);
  }
}

class DioClient {
  late final Dio dio;

  DioClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.newsBaseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );
    dio.interceptors.add(ApiKeyInterceptor());
  }
}