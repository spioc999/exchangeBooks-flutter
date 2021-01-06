class RegistrationBody {
  String username;
  String psw;
  String email;
  String lastName;
  String firstName;
  String city;
  String province;

  RegistrationBody(
      {this.username,
        this.psw,
        this.email,
        this.lastName,
        this.firstName,
        this.city,
        this.province});

  RegistrationBody.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    psw = json['psw'];
    email = json['email'];
    lastName = json['lastName'];
    firstName = json['firstName'];
    city = json['city'];
    province = json['province'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['psw'] = this.psw;
    data['email'] = this.email;
    data['lastName'] = this.lastName;
    data['firstName'] = this.firstName;
    data['city'] = this.city;
    data['province'] = this.province;
    return data;
  }
}