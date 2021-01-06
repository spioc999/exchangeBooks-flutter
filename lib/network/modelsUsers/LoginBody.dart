class LoginBody {
  String email;
  String psw;

  LoginBody({this.email, this.psw});

  LoginBody.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    psw = json['psw'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['psw'] = this.psw;
    return data;
  }
}