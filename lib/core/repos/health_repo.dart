import 'package:dio/dio.dart';
import 'package:flutter_project_template/constants.dart';
import 'package:flutter_project_template/core/network/http.dart';

class HealthRepo {
  Future<Response> check() async {
    return await XHttp.instance.get(ConstantsHttp.health);
  }
}
