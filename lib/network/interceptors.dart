import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_project_template/utils/log_utils.dart';

/// 网络请求拦截器
class CustomInterceptors extends Interceptor {
  String _tag = 'XHttp';
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String data = "";
    if (options.data != null) {
      if (options.data is FormData) {
        Map m = {};
        options.data.fields.forEach((element) {
          m[element.key] = element.value;
        });
        data = "\nbody:${json.encode(m)}";
      } else {
        data = "\nbody:${json.encode(options.data)}";
      }
    }
    if (options.queryParameters.isNotEmpty) {
      data += '\nqueryParameters: ${json.encode(options.queryParameters)}';
    }
    Log.d(_tag,
        "--> ${options.method} ${options.path}\nheaders:${json.encode(options.headers)}$data");
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Log.d(_tag,
        "<-- ${response.statusCode} ${response.requestOptions.path} \nbody:${json.encode(response.data ?? '')}");
    return handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    Log.d(_tag,
        "<-- ${err.response?.statusCode} ${err.requestOptions.path}\nbody:${json.encode(err.response?.data ?? "")}");
    return super.onError(err, handler);
  }
}
