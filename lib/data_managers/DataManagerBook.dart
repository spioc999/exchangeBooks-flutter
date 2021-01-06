import 'package:exchange_books/base/BaseResponse.dart';
import 'package:exchange_books/network/ExchangeBooksException.dart';
import 'package:exchange_books/network/api/BooksApi.dart';
import 'package:exchange_books/network/modelsBooks/AddBookBody.dart';
import 'package:exchange_books/network/modelsBooks/BooksDetailsResponse.dart';
import 'package:exchange_books/network/modelsBooks/GetBooksResponse.dart';
import 'package:exchange_books/network/modelsBooks/SearchBooksResponse.dart';
import 'package:exchange_books/network/modelsBooks/UpdateBookStatusBody.dart';
import 'package:flutter/material.dart';

import 'DataManagerError.dart';
import 'DataManagerResponse.dart';

class DataManagerBook{

  ///GET BOOK'S DETAILS (GET /api/books/details/:isbn)
  Future<DataManagerResponse<BooksDetailsResponse>> getBooksDetailsByIsbn (
      String hostUrl,
      String authorization,
      {@required String isbn}) async{

    DataManagerResponse<BooksDetailsResponse> dmr = DataManagerResponse();

    try{

      var booksApi = BooksApi(hostUrl);

      dmr.response = await booksApi.getBooksDetailsByIsbn(authorization, isbn);

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

  ///ADD NEW BOOK (POST /api/books)
  Future<DataManagerResponse<BaseResponse>> addNewBook (
      String hostUrl,
      String authorization,
      {@required int idBook, @required String note}) async{

    DataManagerResponse<BaseResponse> dmr = DataManagerResponse();

    AddBookBody body = AddBookBody()..idBook = idBook
                                    ..note = note;

    try{

      var booksApi = BooksApi(hostUrl);

      dmr.response = await booksApi.addNewBook(authorization, body);

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

  ///GET ALL BOOKS (GET /api/books)
  Future<DataManagerResponse<GetBooksResponse>> getBooks (
      String hostUrl,
      String authorization) async{

    DataManagerResponse<GetBooksResponse> dmr = DataManagerResponse();

    try{

      var booksApi = BooksApi(hostUrl);

      dmr.response = await booksApi.getBooks(authorization);

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

  ///DELETE BOOK (DELETE /api/books/:id)
  Future<DataManagerResponse<BaseResponse>> deleteBook (
      String hostUrl,
      String authorization,
      {@required int id}) async{

    DataManagerResponse<BaseResponse> dmr = DataManagerResponse();

    try{

      var booksApi = BooksApi(hostUrl);

      dmr.response = await booksApi.deleteBook(authorization, id);

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

  ///UPDATE BOOK'S STATUS (PUT /api/books)
  Future<DataManagerResponse<BaseResponse>> updateBookStatus (
      String hostUrl,
      String authorization,
      {@required int id, @required int status}) async{

    DataManagerResponse<BaseResponse> dmr = DataManagerResponse();

    UpdateBookStatusBody body = UpdateBookStatusBody()..id = id
                                                      ..status = status;

    try{

      var booksApi = BooksApi(hostUrl);

      dmr.response = await booksApi.updateBookStatus(authorization, body);

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

  ///SEARCH BOOKS IN THE SAME PROVINCE (GET /api/books/search)
  Future<DataManagerResponse<SearchBooksResponse>> searchBooks (
      String hostUrl,
      String authorization) async{

    DataManagerResponse<SearchBooksResponse> dmr = DataManagerResponse();

    try{

      var booksApi = BooksApi(hostUrl);

      dmr.response = await booksApi.searchBooks(authorization);

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

}