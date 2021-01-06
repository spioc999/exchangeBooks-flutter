import 'package:exchange_books/base/BaseResponse.dart';
import 'package:exchange_books/network/modelsBooks/SearchBooksResult.dart';

class SearchBooksResponse extends BaseResponse{
  List<SearchBooksResult> result;

  SearchBooksResponse({code, message, this.result});

  SearchBooksResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['result'] != null) {
      result = new List<SearchBooksResult>();
      json['result'].forEach((v) {
        result.add(new SearchBooksResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}