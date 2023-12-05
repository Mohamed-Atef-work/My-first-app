import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  // base url for eCommerce app "postman"
  // https://student.valuxapps.com/api/

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://newsapi.org/",
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = "en",
    String? token,
  }) async {
    //dio?.options.headers = {
    //"lang": lang,
    //"Authorization": token ?? "",
    //"Content-Type": "application/json",
    //"Connection": "keep-alive",
    //"Accept-Encoding": "gzip, deflate, br",
    //"User-Agent": "PostmanRuntime/7.29.2",
    //};

    return await dio!.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response?> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = "en",
    String? token,
  }) async {
    dio?.options.headers = {
      "lang": lang,
      "Authorization": token ?? "",
      "Content-Type": "application/json",
    };

    return await dio!.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response?> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = "en",
    String? token,
  }) async {
    dio?.options.headers = {
      "lang": lang,
      "Authorization": token ?? "",
      "Content-Type": "application/json",
    };

    return await dio!.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
