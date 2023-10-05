import 'package:blogs_task/repository/api.dart';
import 'package:dio/dio.dart';

class BlogRepository {
  Api api = Api();

  Future<Response> getBlogs() async {
    try {
      Response response = await api.sendRequest.get('/blogs');
      return response;
    } catch (ex) {
      rethrow;
    }
  }
}
