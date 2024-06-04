import 'package:dio/dio.dart';
import 'package:flutter_project_template/constants.dart';
import 'package:flutter_project_template/core/network/auth_interceptor.dart';
import 'package:flutter_project_template/core/network/log_interceptor.dart';

class XHttp {
  XHttp._internal();

  /// 网络请求配置
  static final Dio instance = Dio(BaseOptions(baseUrl: ConstantsHttp.baseUrl));
  static final Dio authInstance =
      Dio(BaseOptions(baseUrl: ConstantsHttp.baseUrl));

  /// 初始化dio
  static init() {
    //添加拦截器
    instance.interceptors.add(AuthInterceptor());
    instance.interceptors.add(MyLogInterceptor());
    authInstance.interceptors.add(MyLogInterceptor());
  }
}
