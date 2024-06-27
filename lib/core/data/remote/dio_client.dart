import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_boilerplate/core/config/env.dart';
import 'package:flutter_boilerplate/core/config/di/locator.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  DioClient._();

  static Dio create() {
    final Dio dio = Dio();

    dio.options.baseUrl = Env.baseUrl;
    final SharedPreferences preferences = locator<SharedPreferences>();

    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          logPrint: (object) => debugPrint(object.toString()),
        ),
      );
    }

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        final token = preferences.getString('access_token');

        if (token is String) {
          final Map<String, dynamic> authHeaders = {'Authorization': "Bearer $token"};

          options.headers.addAll(authHeaders);
        }

        return handler.next(options);
      },
    ));

    return dio;
  }
}
