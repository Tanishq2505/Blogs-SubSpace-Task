import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/*
In  this file we create object for dio , add the base url
*/
class Api {
  Dio _dio = Dio(); // create dio object
  Api() {
    _dio.options.baseUrl =
        "https://intent-kit-16.hasura.app/api/rest"; // base url
    _dio.options.headers = {
      "x-hasura-admin-secret": const String.fromEnvironment("ACCESS_KEY"),
    };
    // _dio.interceptors.add(PrettyDioLogger()); // interceptor
  }
  Dio get sendRequest => _dio; // return instance of dio
}
