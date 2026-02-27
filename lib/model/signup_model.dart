class SignupModel {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final String mobileNumber;

  SignupModel({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.mobileNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      "Name": name,
      "Email": email,
      "Password": password,
      "ConfirmPassword": confirmPassword,
      "MobileNumber": mobileNumber,
    };
  }
}
