import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:exchange_books/base/BaseResponse.dart';
import 'package:exchange_books/helpers/ApiHelper.dart';
import 'package:exchange_books/network/interceptors/InterceptorFactory.dart';
import 'package:exchange_books/network/interceptors/InterceptorSetter.dart';
import 'package:exchange_books/network/modelsBooks/AddBookBody.dart';
import 'package:exchange_books/network/modelsBooks/BooksDetailsResponse.dart';
import 'package:exchange_books/network/modelsBooks/GetBooksResponse.dart';
import 'package:exchange_books/network/modelsBooks/SearchBooksResponse.dart';
import 'package:exchange_books/network/modelsBooks/UpdateBookStatusBody.dart';
import 'package:exchange_books/values/HttpConstants.dart';

import '../ExchangeBooksException.dart';

class BooksApi{
  final String _hostUrl;
  static const String _apiBooksPrefix = "/api/books";

  BooksApi(this._hostUrl);

  ///GET BOOK'S DETAILS (GET /api/books/details/:isbn)
  Future<BooksDetailsResponse> getBooksDetailsByIsbn(String authorization, String isbn) async {

    if(authorization == null) {
      throw ExchangeBooksException(HttpConstants.defaultExceptionErrorCode, "Missing required param: authorization");
    }

    if(isbn == null) {
      throw ExchangeBooksException(HttpConstants.defaultExceptionErrorCode, "Missing required param: isbn");
    }

    final path = _apiBooksPrefix + "/details/" + isbn;

    Dio client = Dio();

    List<Interceptor> interceptors = [
      InterceptorFactory.createAuthorizedCallsInterceptor(authorization, client)
    ];

    InterceptorSetter.setInterceptors(client, this._hostUrl, interceptors);

    try{

      var httpResponse = await client.get(path);

      var response = BooksDetailsResponse.fromJson(httpResponse.data);

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

  ///ADD NEW BOOK (POST /api/books)
  Future<BaseResponse> addNewBook (String authorization, AddBookBody body) async {

    if(authorization == null) {
      throw ExchangeBooksException(HttpConstants.defaultExceptionErrorCode, "Missing required param: authorization");
    }

    if(body == null) {
      throw ExchangeBooksException(HttpConstants.defaultExceptionErrorCode, "Missing required param: body");
    }
    
    final path = _apiBooksPrefix;

    Dio client = Dio();

    List<Interceptor> interceptors = [
      InterceptorFactory.createAuthorizedCallsInterceptor(authorization, client),
      InterceptorFactory.createAddBodyInterceptors(json.encode(body.toJson()))
    ];

    InterceptorSetter.setInterceptors(client, _hostUrl, interceptors);

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

  ///GET BOOKS OF USER (GET /api/books)
  Future<GetBooksResponse> getBooks (String authorization) async {

    if(authorization == null) {
      throw ExchangeBooksException(HttpConstants.defaultExceptionErrorCode, "Missing required param: authorization");
    }

    final path = _apiBooksPrefix;

    Dio client = Dio();

    List<Interceptor> interceptors = [
      InterceptorFactory.createAuthorizedCallsInterceptor(authorization, client)
    ];

    InterceptorSetter.setInterceptors(client, _hostUrl, interceptors);

    try{

      var httpResponse = await client.get(path);

      var response = GetBooksResponse.fromJson(httpResponse.data);

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

  ///DELETE BOOK (DELETE /api/books/:id)
  Future<BaseResponse> deleteBook (String authorization, int id) async {
    if(authorization == null) {
      throw ExchangeBooksException(HttpConstants.defaultExceptionErrorCode, "Missing required param: authorization");
    }

    if(id == null) {
      throw ExchangeBooksException(HttpConstants.defaultExceptionErrorCode, "Missing required param: id");
    }

    final path = _apiBooksPrefix + "/" + id.toString();

    Dio client = Dio();

    List<Interceptor> interceptors = [
      InterceptorFactory.createAuthorizedCallsInterceptor(authorization, client)
    ];

    InterceptorSetter.setInterceptors(client, _hostUrl, interceptors);

    try{

      var httpResponse = await client.delete(path);

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

  ///UPDATE BOOK'S STATUS (PUT /api/books)
  Future<BaseResponse> updateBookStatus (String authorization, UpdateBookStatusBody body) async {

    if(authorization == null) {
      throw ExchangeBooksException(HttpConstants.defaultExceptionErrorCode, "Missing required param: authorization");
    }

    if(body == null) {
      throw ExchangeBooksException(HttpConstants.defaultExceptionErrorCode, "Missing required param: body");
    }

    final path = _apiBooksPrefix;

    Dio client = Dio();

    List<Interceptor> interceptors = [
      InterceptorFactory.createAuthorizedCallsInterceptor(authorization, client),
      InterceptorFactory.createAddBodyInterceptors(json.encode(body.toJson()))
    ];

    InterceptorSetter.setInterceptors(client, _hostUrl, interceptors);

    try{

      var httpResponse = await client.put(path);

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

  ///SEARCH BOOKS IN THE SAME PROVINCE (GET /api/books/search)
  Future<SearchBooksResponse> searchBooks(String authorization) async {

    if(authorization == null) {
      throw ExchangeBooksException(HttpConstants.defaultExceptionErrorCode, "Missing required param: authorization");
    }

    final path = _apiBooksPrefix + "/search";

    Dio client = Dio();

    List<Interceptor> interceptors = [
      InterceptorFactory.createAuthorizedCallsInterceptor(authorization, client)
    ];

    InterceptorSetter.setInterceptors(client, _hostUrl, interceptors);

    try{

      var httpResponse = await client.get(path);

      var response = SearchBooksResponse.fromJson(httpResponse.data);

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