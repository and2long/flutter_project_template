import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_project_template/constants.dart';
import 'package:flutter_project_template/utils/log_util.dart';

class MyLogInterceptor extends Interceptor {
  final String _tag = 'XHTTP';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String data = '\nheaders: ${options.headers}';
    if (options.data != null) {
      if (options.data is FormData) {
        Map m = {};
        options.data.fields.forEach((element) {
          m[element.key] = element.value;
        });
        data += '\nbody:${json.encode(m)}';
      } else {
        data += '\nbody:${json.encode(options.data)}';
      }
    }
    if (options.queryParameters.isNotEmpty) {
      data += '\nqueryParams: ${json.encode(options.queryParameters)}';
    }
    String path = '';
    if (options.path.startsWith('http')) {
      path = options.path;
    } else {
      path = ConstantsHttp.baseUrl + options.path;
    }
    Log.d(_tag, '--> ${options.method} $path$data');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    String path = response.requestOptions.path;
    if (!path.startsWith('http')) {
      path = ConstantsHttp.baseUrl + path;
    }
    String data = json.encode(response.data ?? '');
    Log.d(_tag, '<-- ${response.statusCode} $path \nbody: $data');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String path = err.requestOptions.path;
    if (!path.startsWith('http')) {
      path = ConstantsHttp.baseUrl + path;
    }
    String data = json.encode(err.response?.data ?? '');
    Log.d(_tag, '<-- ${err.response?.statusCode} $path\nbody: $data');
    super.onError(err, handler);
  }
}
