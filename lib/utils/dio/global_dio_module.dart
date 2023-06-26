import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

Dio dioBuilder(String baseUrl) {
  final BaseOptions options = BaseOptions(
    baseUrl: baseUrl,
    receiveDataWhenStatusError: true,
  );

  final Dio dio = Dio(options);

  dio.interceptors.add(PrettyDioLogger());

  return dio;
}
