import 'package:exchange_books/models/User.dart';

class LoginResult {
  String bearerToken;
  User user;

  LoginResult({this.bearerToken, this.user});

  LoginResult.fromJson(Map<String, dynamic> json) {
    bearerToken = json['bearerToken'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bearerToken'] = this.bearerToken;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}