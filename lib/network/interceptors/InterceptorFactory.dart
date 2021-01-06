import 'package:dio/dio.dart';

import 'AddBodyInterceptor.dart';
import 'AddHeadersInterceptor.dart';
import 'AddQueryParamsInterceptor.dart';
import 'AuthorizedCallsInterceptor.dart';
import 'LoggerInterceptor.dart';
import 'UnauthorizedCallsInterceptor.dart';

class InterceptorFactory{

  ///
  static Interceptor createLoggerInterceptor() {
    return LoggerInterceptor(
        request : true,
        requestHeader : true,
        requestBody : true,
        responseHeader : true,
        responseBody : true,
        error : true,
        maxWidth : 90,
        compact : true);
  }

  ///
  static Interceptor createAuthorizedCallsInterceptor(String authorization, Dio client){
    return AuthorizedCallsInterceptor(authorization,client);
  }

  ///
  static Interceptor createUnautorizedCallsInterceptor(String clientId, String clientSecret){
    return UnauthorizedCallsInterceptor(clientId,clientSecret);
  }

  ///
  static Interceptor createAddHeadersInterceptors(Map<String,dynamic> headers){
    return AddHeadersInterceptor(headers);
  }

  ///
  static Interceptor createAddBodyInterceptors(dynamic body){
    return AddBodyInterceptor(body);
  }

  ///
  static Interceptor createAddQueryParamsInterceptors(Map<String,dynamic> params){
    return AddQueryParamsInterceptor(params);
  }
}