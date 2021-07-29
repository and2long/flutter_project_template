import 'package:dio/dio.dart';
import 'package:flutter_project_template/network/interceptors.dart';

class XHttp {
  XHttp._internal();

  /// 网络请求配置
  static final Dio instance = Dio();

  /// 初始化dio
  static init() {
    //添加拦截器
    instance.interceptors.add(CustomInterceptors());
  }
}

