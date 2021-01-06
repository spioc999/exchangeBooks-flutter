import 'package:dio/dio.dart';
import 'package:exchange_books/values/HttpConstants.dart';

class BaseOptionsInterceptor extends Interceptor{
  
  String _baseUrl;

  BaseOptionsInterceptor(this._baseUrl);

  @override
  Future onRequest(RequestOptions options) {
    
    options.responseType = ResponseType.json;
    options.contentType = Headers.jsonContentType;
    options.headers[HttpConstants.headerUserAgent] = HttpConstants.headerUserAgentValue;
    options.headers[HttpConstants.headerAccept] = HttpConstants.headerAcceptValue;
    options.baseUrl = _baseUrl;
    //options.connectTimeout = 15;

    return super.onRequest(options);
  }
}