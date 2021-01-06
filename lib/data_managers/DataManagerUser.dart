import 'dart:convert';

import 'package:exchange_books/base/BaseResponse.dart';
import 'package:exchange_books/data_managers/DataManagerResponse.dart';
import 'package:exchange_books/models/User.dart';
import 'package:exchange_books/network/ExchangeBooksException.dart';
import 'package:exchange_books/network/api/UsersApi.dart';
import 'package:exchange_books/network/modelsUsers/LoginBody.dart';
import 'package:exchange_books/network/modelsUsers/LoginResponse.dart';
import 'package:exchange_books/network/modelsUsers/RegistrationBody.dart';
import 'package:exchange_books/values/StorageKeys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'DataManagerError.dart';

class DataManagerUser {

  ///LOGIN USER (POST /api/users/login)
  Future<DataManagerResponse<LoginResponse>> login (
      String hostUrl,
      String clientId,
      String clientSecret,
      {@required String email,
       @required String psw }) async{
    
    DataManagerResponse<LoginResponse> dmr = DataManagerResponse();
    
    LoginBody body = LoginBody()..email = email
                                ..psw = psw;
    
    try{
      
      var userApi = UsersApi(hostUrl);
      
      dmr.response = await userApi.login(clientId, clientSecret, body);
      
      return dmr;
      
    } on ExchangeBooksException catch (e) {
      
      var dmerror = DataManagerError();
      dmerror.status = e.code;
      dmerror.message = e.message;
      dmerror.isHttp = e.isHttp;
      dmr.error = dmerror;
      //Restituisco l'errore
      return dmr;
      
    }
  }

  ///REGISTER NEW USER (POST /api/users)
  Future<DataManagerResponse<BaseResponse>> registerNewUser (
      String hostUrl,
      String clientId,
      String clientSecret,
      {@required String username, @required String psw, @required String email,
        @required String lastName, @required String firstName, @required String city, @required String province}) async{

    DataManagerResponse<BaseResponse> dmr = DataManagerResponse();

    RegistrationBody body = RegistrationBody()..username = username
                                              ..psw = psw
                                              ..email = email
                                              ..lastName = lastName
                                              ..firstName = firstName
                                              ..city = city
                                              ..province = province;

    try{

      var userApi = UsersApi(hostUrl);

      dmr.response = await userApi.registerNewUser(clientId, clientSecret, body);

      return dmr;

    } on ExchangeBooksException catch (e) {

      var dmerror = DataManagerError();
      dmerror.status = e.code;
      dmerror.message = e.message;
      dmerror.isHttp = e.isHttp;
      dmr.error = dmerror;
      //Restituisco l'errore
      return dmr;

    }
  }

  ///GET CURRENT USER FROM CACHE
  Future<DataManagerResponse<User>> getCurrentUser() async{

    DataManagerResponse<User> dmr = DataManagerResponse();
    
    var storage = FlutterSecureStorage();
    
    String jsonData = await storage.read(key: StorageKeys.USER);
    
    if(jsonData == null) {
      DataManagerError dmerror = DataManagerError();
      dmerror.status = 0;
      dmerror.message = DataManagerError.ERR_CACHE;
      dmr.error = dmerror;
      return dmr;
    }

    try{
      
      dmr.response = User.fromJson(jsonDecode(jsonData));

      return dmr;

    } catch (e) {

      var dmerror = DataManagerError();
      dmerror.status = 0;
      dmerror.message = DataManagerError.ERR_CACHE;
      dmr.error = dmerror;
      //Restituisco l'errore
      return dmr;

    }
  }

  ///SAVE CURRENT USER IN CACHE
  Future<DataManagerResponse<void>> saveCurrentUser(User user) async{

    DataManagerResponse<void> dmr = DataManagerResponse();

    try{

      var storage = FlutterSecureStorage();
      await storage.write(
          key: StorageKeys.USER,
          value: jsonEncode(user.toJson()));

      return dmr;

    } catch (e) {
      var dmerror = DataManagerError();
      dmerror.status = 0;
      dmerror.message = DataManagerError.ERR_CACHE_WRITE;
      dmr.error = dmerror;
      return dmr;
    }

  }

  ///GET SAVED EMAIL FROM CACHE
  Future<DataManagerResponse<String>> getSavedEmail() async{

    DataManagerResponse<String> dmr = DataManagerResponse();

    var storage = FlutterSecureStorage();

    String email = await storage.read(key: StorageKeys.EMAIL);

    if(email == null) {
      DataManagerError dmerror = DataManagerError();
      dmerror.status = 0;
      dmerror.message = DataManagerError.ERR_CACHE;
      dmr.error = dmerror;
      return dmr;
    }

    dmr.response = email;

    return dmr;

  }

  ///SAVE EMAIL IN CACHE
  Future<DataManagerResponse<void>> saveEmail(String email) async{

    DataManagerResponse<void> dmr = DataManagerResponse();

    try{

      var storage = FlutterSecureStorage();
      await storage.write(
          key: StorageKeys.EMAIL,
          value: email);

      return dmr;

    } catch (e) {
      var dmerror = DataManagerError();
      dmerror.status = 0;
      dmerror.message = DataManagerError.ERR_CACHE_WRITE;
      dmr.error = dmerror;
      return dmr;
    }

  }

  ///GET SAVED PASSWORD
  Future<DataManagerResponse<String>> getSavedPassword() async{

    DataManagerResponse<String> dmr = DataManagerResponse();

    var storage = FlutterSecureStorage();

    String psw = await storage.read(key: StorageKeys.PASSWORD);

    if(psw == null) {
      DataManagerError dmerror = DataManagerError();
      dmerror.status = 0;
      dmerror.message = DataManagerError.ERR_CACHE;
      dmr.error = dmerror;
      return dmr;
    }

    dmr.response = psw;

    return dmr;

  }

  ///SAVE PASSWORD IN CACHE
  Future<DataManagerResponse<void>> savePassword(String password) async{

    DataManagerResponse<void> dmr = DataManagerResponse();

    try{

      var storage = FlutterSecureStorage();
      await storage.write(
          key: StorageKeys.PASSWORD,
          value: password);

      return dmr;

    } catch (e) {
      var dmerror = DataManagerError();
      dmerror.status = 0;
      dmerror.message = DataManagerError.ERR_CACHE_WRITE;
      dmr.error = dmerror;
      return dmr;
    }

  }

  ///GET BEARER TOKEN
  Future<DataManagerResponse<String>> getBearerToken() async{

    DataManagerResponse<String> dmr = DataManagerResponse();

    var storage = FlutterSecureStorage();

    String bearerToken = await storage.read(key: StorageKeys.BEARER_TOKEN);

    if(bearerToken == null) {
      DataManagerError dmerror = DataManagerError();
      dmerror.status = 0;
      dmerror.message = DataManagerError.ERR_CACHE;
      dmr.error = dmerror;
      return dmr;
    }

    dmr.response = bearerToken;

    return dmr;

  }

  ///SAVE BEARER TOKEN IN CACHE
  Future<DataManagerResponse<void>> saveBearerToken(String bearerToken) async{

    DataManagerResponse<void> dmr = DataManagerResponse();

    try{

      var storage = FlutterSecureStorage();
      await storage.write(
          key: StorageKeys.BEARER_TOKEN,
          value: bearerToken);

      return dmr;

    } catch (e) {
      var dmerror = DataManagerError();
      dmerror.status = 0;
      dmerror.message = DataManagerError.ERR_CACHE_WRITE;
      dmr.error = dmerror;
      return dmr;
    }

  }

  ///LOGOUT -> REMOVE BEARERTOKEN AND USER
  Future<DataManagerResponse<void>> logout() async{

    DataManagerResponse<void> dmr = DataManagerResponse();

    try{

      var storage = FlutterSecureStorage();

      await storage.delete(key: StorageKeys.USER);
      await storage.delete(key: StorageKeys.BEARER_TOKEN);

      return dmr;

    } catch (e) {
      var dmerror = DataManagerError();
      dmerror.status = 0;
      dmerror.message = DataManagerError.ERR_CACHE_DELETE;
      dmr.error = dmerror;
      return dmr;
    }

  }
  
}