class User {
  String username;
  String email;
  String lastName;
  String firstName;
  String city;
  String province;

  User(
      {this.username,
        this.email,
        this.lastName,
        this.firstName,
        this.city,
        this.province});

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    lastName = json['lastName'];
    firstName = json['firstName'];
    city = json['city'];
    province = json['province'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['email'] = this.email;
    data['lastName'] = this.lastName;
    data['firstName'] = this.firstName;
    data['city'] = this.city;
    data['province'] = this.province;
    return data;
  }
}