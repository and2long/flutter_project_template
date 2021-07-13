import 'package:dio/dio.dart';
import 'package:flutter_project_template/network/interceptors.dart';
import 'package:flutter_project_template/utils/log_utils.dart';

class XHttp {
  XHttp._internal();

  static const String TAG = 'XHttp';

  /// 网络请求配置
  static final Dio _dio = Dio();

  /// 初始化dio
  static init() {
    //添加拦截器
    _dio.interceptors.add(CustomInterceptors());
  }

  /// get请求
  static Future<Map<String, dynamic>?> get(String url,
      {Map<String, dynamic>? params}) async {
    try {
      Response response;
      if (params == null) {
        response = await _dio.get(url);
      } else {
        response = await _dio.get(url, queryParameters: params);
      }
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode.toString().startsWith('5')) {
          return null;
        }
        return e.response!.data;
      } else {
        return null;
      }
    } catch (e) {
      Log.d(TAG, e);
      return null;
    }
  }

  /// post json请求
  static Future<Map<String, dynamic>?> postJson(String url,
      [Map<String, dynamic>? data]) async {
    try {
      Response response = await _dio.post(url, data: data);
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode.toString().startsWith('5')) {
          return null;
        }
        return e.response!.data;
      } else {
        return null;
      }
    } catch (e) {
      Log.d(TAG, e);
      return null;
    }
  }

  /// post form请求，携带token
  static Future postFormData(String url,
      {required FormData data, Options? options}) async {
    try {
      Response response = await _dio.post(url, data: data, options: options);
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode.toString().startsWith('5')) {
          return null;
        }
        return e.response!.data;
      } else {
        return null;
      }
    } catch (e) {
      Log.d(TAG, e);
      return null;
    }
  }
}
