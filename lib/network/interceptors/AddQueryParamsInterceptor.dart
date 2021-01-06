import 'package:dio/dio.dart';

class AddQueryParamsInterceptor extends Interceptor{

  Map<String,dynamic> _myParams;

  ///
  AddQueryParamsInterceptor(this._myParams);

  @override
  Future onRequest(RequestOptions options) {

    options.queryParameters = _myParams;

    return super.onRequest(options);
  }
}