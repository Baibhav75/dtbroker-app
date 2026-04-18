class LoginResponseModel {
  final bool status;
  final String message;
  final UserData? data;

  LoginResponseModel({required this.status, required this.message, this.data});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      status: json["Status"],
      message: json["Message"],
      data: json["Data"] != null ? UserData.fromJson(json["Data"]) : null,
    );
  }
}

class UserData {
  final int id;
  final String name;
  final String email;
  final String mobileNumber;
  final String uniqueId;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.mobileNumber,
    required this.uniqueId
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json["Id"],
      name: json["Name"],
      email: json["Email"],
      mobileNumber: json["MobileNumber"],
      uniqueId: json["UniqueId"],
    );
  }
}

// class LoginData {
//   final int id;
//   final String token;
//
//   LoginData({
//     required this.id,
//     required this.token,
//   });
//
//   factory LoginData.fromJson(Map<String, dynamic> json) {
//     return LoginData(
//       id: json['id'],
//       token: json['token'],
//     );
//   }
// }

