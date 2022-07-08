import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper {
  static Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://student.valuxapps.com/api/",
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    @required String url,
    Map<String, dynamic> query,
    String lang = "en",
    String token,
  }) async {
    dio.options.headers = {
      "lang": lang,
      "Authorization": token ?? '',
      "Content-Type": "application/json",
    };
    return await dio.get(
        url,
        queryParameters: query??null,
    );
  }

  static Future<Response> postData({
    @required String url,
    @required Map<String, dynamic> data,
    String lang = "en",
    String token,
    Map<String, dynamic> query,
  }) async {
    dio.options.headers = {
      "lang": lang,
      "Authorization": token ?? '',
      "Content-Type": "application/json",
    };
    return await dio.post(
      url,
      data: data,
      queryParameters: query,
    );
  }

  static Future<Response> putData({
    @required String url,
    @required Map<String, dynamic> data,
    String lang = "en",
    String token,
    Map<String, dynamic> query,
  }) async {
    dio.options.headers = {
      "lang": lang,
      "Authorization": token ?? '',
      "Content-Type": "application/json",
    };
    return await dio.put(
      url,
      data: data,
      queryParameters: query,
    );
  }

}

//https://newsapi.org/v2/top-headlines?country=eg&category=business&apikey=e93441c24e6c4b539e5f03eafed5e841

// base url : https://newsapi.org/
// method (url) : v2/top-headlines?
// queries : country=eg&category=business&apikey=e93441c24e6c4b539e5f03eafed5e841
