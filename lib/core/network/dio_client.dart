import 'package:dio/dio.dart';

import '../utils/constants.dart';

class DioClient {
  final Dio _dio = Dio();

  DioClient() {
    _dio.options.baseUrl = AppConstants.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 15);
    _dio.options.receiveTimeout = const Duration(seconds: 15);
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    _dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true, error: true),
    );
  }

  Dio get dio => _dio;
}
