import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:exchange_books/base/BaseResponse.dart';
import 'package:exchange_books/helpers/ApiHelper.dart';
import 'package:exchange_books/network/ExchangeBooksException.dart';
import 'package:exchange_books/network/interceptors/InterceptorFactory.dart';
import 'package:exchange_books/network/interceptors/InterceptorSetter.dart';
import 'package:exchange_books/network/modelsUsers/LoginBody.dart';
import 'package:exchange_books/network/modelsUsers/LoginResponse.dart';
import 'package:exchange_books/network/modelsUsers/RegistrationBody.dart';
import 'package:exchange_books/values/HttpConstants.dart';

class UsersApi{
  final String _hostUrl;
  static const String _apiUsersPrefix = "/api/users";

  UsersApi(this._hostUrl);

  ///LOGIN USER (POST /api/users/login)
  Future<LoginResponse> login(String clientId,
      String clientSecret,
      LoginBody body) async {

    if(clientId == null || clientSecret == null){
      throw ExchangeBooksException(HttpConstants.defaultExceptionErrorCode, "Missing required param: authorization");
    }

    if(body == null){
      throw ExchangeBooksException(HttpConstants.defaultExceptionErrorCode, "Missing required param: body");
    }

    final path = _apiUsersPrefix + "/login";

    Dio client = Dio();

    List<Interceptor> interceptors = [
      InterceptorFactory.createUnautorizedCallsInterceptor(clientId, clientSecret),
      InterceptorFactory.createAddBodyInterceptors(json.encode(body.toJson()))
    ];

    InterceptorSetter.setInterceptors(client, this._hostUrl, interceptors);

    try{

      var httpResponse = await client.post(path);

      var response = LoginResponse.fromJson(httpResponse.data);

      if(httpResponse.statusCode >= 400){
        throw ExchangeBooksException(httpResponse.statusCode, httpResponse.toString(), isHttp: true);
      }else if(ApiHelper.isSuccessfulResponse(response.code)){
        return response;
      }else{
        throw ExchangeBooksException(response.code, response.message);
      }

    } on ExchangeBooksException catch (exchangeBooksException){
      throw exchangeBooksException;
    } catch (e) {
      throw ExchangeBooksException(0, e.toString());
    }

  }

  ///REGISTER NEW USER (POST /api/users)
  Future<BaseResponse> registerNewUser (String clientId,
      String clientSecret,
      RegistrationBody body) async{

    if(clientId == null || clientSecret == null){
      throw ExchangeBooksException(HttpConstants.defaultExceptionErrorCode, "Missing required param: authorization");
    }

    if(body == null){
      throw ExchangeBooksException(HttpConstants.defaultExceptionErrorCode, "Missing required param: body");
    }

    final path = _apiUsersPrefix;

    Dio client = Dio();

    List<Interceptor> interceptors = [
      InterceptorFactory.createUnautorizedCallsInterceptor(clientId, clientSecret),
      InterceptorFactory.createAddBodyInterceptors(json.encode(body.toJson()))
    ];

    InterceptorSetter.setInterceptors(client, this._hostUrl, interceptors);

    try{

      var httpResponse = await client.post(path);

      var response = BaseResponse.fromJson(httpResponse.data);

      if(httpResponse.statusCode >= 400){
        throw ExchangeBooksException(httpResponse.statusCode, httpResponse.toString(), isHttp: true);
      }else if(ApiHelper.isSuccessfulResponse(response.code)){
        return response;
      }else{
        throw ExchangeBooksException(response.code, response.message);
      }

    } on ExchangeBooksException catch (exchangeBooksException){
      throw exchangeBooksException;
    } catch (e) {
      throw ExchangeBooksException(0, e.toString());
    }

  }

}