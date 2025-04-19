class LoginReq {
  String? userName;
  String? password;

  LoginReq({
    this.userName,
    this.password,
  });

  Map<String, dynamic> toJson() => {
        'username': userName,
        'password': password,
      };

  factory LoginReq.fromJson(Map<String, dynamic> json) => LoginReq(
        userName: json['username'],
        password: json['password'],
      );
}
