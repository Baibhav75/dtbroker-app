class LoginRequestModel {
  final String mobile;
  final String password;

  LoginRequestModel({required this.mobile, required this.password});

  Map<String, dynamic> toJson() {
    return {"Mobile": mobile, "Password": password};
  }
}
