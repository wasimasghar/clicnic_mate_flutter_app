// Shared Dio client for JSON requests to the ClinicMate backend.
// Adds the current bearer token and normalizes Dio failures as ApiException.

import 'dart:convert';
import 'package:dio/dio.dart';

import '../config/app_config.dart';
import '../storage/token_storage.dart';
import 'api_exception.dart';

/// Sends authenticated JSON requests and returns decoded response bodies.
class ApiClient {
  ApiClient({required TokenStorage tokenStorage, this.onUnauthorized, Dio? dio})
    : _tokenStorage = tokenStorage,
      _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: AppConfig.baseUrl,
              connectTimeout: const Duration(seconds: 15),
              receiveTimeout: const Duration(seconds: 60),
              headers: const {
                'Accept': 'application/json',
                'Content-Type': 'application/json',
              },
            ),
          ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _tokenStorage.readToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
      ),
    );
  }

  final Dio _dio;
  final TokenStorage _tokenStorage;
  final void Function()? onUnauthorized;

  Future<dynamic> get(String path, {Map<String, dynamic>? queryParameters}) =>
      _request(() => _dio.get<dynamic>(path, queryParameters: queryParameters));

  Future<dynamic> post(String path, {Object? data}) =>
      _request(() => _dio.post<dynamic>(path, data: data));

  Future<dynamic> patch(String path, {Object? data}) =>
      _request(() => _dio.patch<dynamic>(path, data: data));

  Future<dynamic> delete(String path) =>
      _request(() => _dio.delete<dynamic>(path));

  Future<Response<ResponseBody>> postStream(String path, {Object? data}) async {
    try {
      return await _dio.post<ResponseBody>(
        path,
        data: data,
        options: Options(
          responseType: ResponseType.stream,
          headers: const {
            'Accept': 'text/event-stream',
            'Content-Type': 'application/json',
          },
        ),
      );
    } on DioException catch (error) {
      if (error.response?.statusCode == 401) onUnauthorized?.call();
      dynamic body = error.response?.data;
      if (body is ResponseBody) {
        try {
          final bytes = await body.stream.fold<List<int>>(
            <int>[],
            (all, chunk) => all..addAll(chunk),
          );
          body = jsonDecode(utf8.decode(bytes));
        } catch (_) {
          body = null;
        }
      }
      throw ApiException.fromResponse(error.response?.statusCode, body);
    }
  }

  Future<dynamic> _request(Future<Response<dynamic>> Function() send) async {
    try {
      return (await send()).data;
    } on DioException catch (error) {
      if (error.response?.statusCode == 401) onUnauthorized?.call();
      throw ApiException.fromResponse(
        error.response?.statusCode,
        error.response?.data,
      );
    }
  }
}
