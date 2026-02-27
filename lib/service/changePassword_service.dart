import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/change_password_model.dart';


class ChangePasswordService {
  final String _url =
      "https://niveshcore.com/api/ChangePassword";

  Future<ChangePasswordResponse> changePassword({
    required String mobile,
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final response = await http.post(
      Uri.parse(_url),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "MobileNumber": mobile,
        "Password": oldPassword,
        "NewPassword": newPassword,
        "ConfirmPassword": confirmPassword,
      }),
    );

    print("Status Code: ${response.statusCode}");
    print("Body: ${response.body}");

    final jsonData = jsonDecode(response.body);

    return ChangePasswordResponse.fromJson(jsonData);
  }
}
