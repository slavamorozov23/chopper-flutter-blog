import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:connectivity/connectivity.dart';

class LargeFileMobileInterceptor implements Interceptor {
  final Connectivity _connectivity = Connectivity();

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(
      Chain<BodyType> chain) async {
    // Проверка типа сетевого соединения
    var connectivityResult = await _connectivity.checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile) {
      // Проверка, содержит ли путь URL ключевые слова
      final uri = chain.request.url;

      var contentLengthHeader = chain.request.headers['Content-Length'];
      if (contentLengthHeader != null) {
        int contentLength = int.tryParse(contentLengthHeader) ?? 0;
        if (contentLength > 10485760) {
          // Проверка, если размер больше 10MB
          print(
              'Warning: You are downloading a large file ($contentLength bytes) over mobile data.');
        }
      }
      if (uri.toString().contains('posts') ||
          uri.toString().contains('video') ||
          uri.toString().contains('file')) {
        throw MobileDataCostException();
      }
    }

    return chain.proceed(chain.request);
  }
}

class MobileDataCostException implements Exception {
  final message = 'Загрузка обьемных данных требует подключения к WiFi';
  @override
  String toString() => message;
}
