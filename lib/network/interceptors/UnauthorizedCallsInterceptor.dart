import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:exchange_books/values/HttpConstants.dart';

class UnauthorizedCallsInterceptor extends Interceptor{

  String _clientId;
  String _clientSecret;

  ///
  UnauthorizedCallsInterceptor(this._clientId, this._clientSecret);

  @override
  Future onRequest(RequestOptions options) {

    options.headers[HttpConstants.authorizationHeader] = HttpConstants.basic + " " + this.buildBasicAuth(_clientId, _clientSecret);

    return super.onRequest(options);
  }


  /// Method for creating basic auth base64 key giving [clientId] and [clientSecret]
  String buildBasicAuth(String clientId, String clientSecret){

    String credentials = clientId + ":" + clientSecret;
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    return stringToBase64.encode(credentials);

  }
}