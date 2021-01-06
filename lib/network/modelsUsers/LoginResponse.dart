import 'package:exchange_books/base/BaseResponse.dart';
import 'package:exchange_books/network/modelsUsers/LoginResult.dart';

class LoginResponse extends BaseResponse{
  LoginResult result;

  LoginResponse({code, message, this.result});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    result = json['result'] != null ? new LoginResult.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}