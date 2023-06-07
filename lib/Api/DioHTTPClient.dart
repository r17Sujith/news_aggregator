
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:twenty4_hours/Api/ApiEndPoints.dart';
import 'package:twenty4_hours/Api/ApiKeyStrings.dart';
import 'package:twenty4_hours/Api/ApiKeys.dart';

class DioHttpClient{
  late Dio dio;

  DioHttpClient(){
    dio = Dio(getBaseOptions());
    dio.interceptors.add(getInterceptor());
  }

  Future<Response> getRequest(String endPoint, Map<String, dynamic> queryParams,[Options? option])  async {
    late Response response;
    try {
      response = await dio.get(endPoint, queryParameters: queryParams,options: option);
    }  on DioError catch (e) {
      if (e.response != null && e.response!.statusCode !=null && e.response!.statusCode == 401) {
        if (kDebugMode) {
          print("DioError: ${e.message}, ${e.response}");
        }
      } else {
        if (kDebugMode) {
          print("DioError: ${e.message}, ${e.response}");
        }
      }
    }
    return response;
  }


  BaseOptions getBaseOptions(){
    return BaseOptions(
      baseUrl: ApiEndPoints.baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    );
  }

  InterceptorsWrapper getInterceptor(){
    return InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        if (kDebugMode) {
          print("Request : Method ${options.method}, ${options.uri},  ${options.headers},  ${options.data}");
          print("Request completed : ${handler.isCompleted}");
        }
        return handler.next(options);
      },
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        if (kDebugMode) {
          print("Response: ${response.data}");
          print("JsonResponse: ${jsonEncode(response.data)}");
        }
        return handler.next(response);
      },
      onError: (DioError e, ErrorInterceptorHandler handler) {
        if (kDebugMode) {
          print("Error ${e.message}");
        }
        return handler.next(e);
      },
    );
  }

  Options getOptions() {
    Map<String, dynamic> header =  {};
    header.putIfAbsent(ApiKeyStrings.apiKey, () => ApiKeys.apiKey);
    return Options(headers: header );
  }
}