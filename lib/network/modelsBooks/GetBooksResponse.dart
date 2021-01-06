import 'package:exchange_books/base/BaseResponse.dart';
import 'package:exchange_books/network/modelsBooks/GetBooksResult.dart';

class GetBooksResponse extends BaseResponse{

  List<GetBooksResult> result;

  GetBooksResponse({code, message, this.result});

  GetBooksResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['result'] != null) {
      result = new List<GetBooksResult>();
      json['result'].forEach((v) {
        result.add(new GetBooksResult.fromJson(v));
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