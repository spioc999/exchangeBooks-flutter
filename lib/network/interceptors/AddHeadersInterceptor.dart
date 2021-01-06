import 'package:dio/dio.dart';

class AddHeadersInterceptor extends Interceptor{

  Map<String,dynamic> _myHeaders;

  ///
  AddHeadersInterceptor(this._myHeaders);

  @override
  Future onRequest(RequestOptions options) {

    options.headers.addAll(_myHeaders);

    return super.onRequest(options);
  }
}