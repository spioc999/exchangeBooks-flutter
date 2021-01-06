import 'package:dio/dio.dart';

class AddBodyInterceptor extends Interceptor{

  dynamic _body;

  AddBodyInterceptor(this._body);

  @override
  Future onRequest(RequestOptions options) {
    options.data = _body;

    return super.onRequest(options);
  }
}