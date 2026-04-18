import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../model/login_request_model.dart';
import '../model/login_response_model.dart';

class AuthService   {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<LoginResponseModel> login(LoginRequestModel request) async {
    final url = Uri.parse("https://niveshcore.com/api/signup/login");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(request.toJson()),
    );

    final data = jsonDecode(response.body);
    final loginResponse = LoginResponseModel.fromJson(data);

    // if (loginResponse.status && loginResponse.data != null) {
    //   await _storage.write(
    //     key: "user_id",
    //     value: loginResponse.data!.id.toString(),
    //   );
    //
    //   print("✅ USER ID SAVED: ${loginResponse.data!.id}");
    // }
    if (loginResponse.status && loginResponse.data != null) {
      final user = loginResponse.data!;

      await _storage.write(
        key: "user_id",
        value: user.id.toString(),
      );

      await _storage.write(
        key: "unique_id",   // 🔥 NEW LINE
        value: user.uniqueId,
      );

      print("✅ USER ID SAVED: ${user.id}");
      print("✅ UNIQUE ID SAVED: ${user.uniqueId}");
    }

    return loginResponse;
  }

  Future<int?> getUserId() async {
    String? id = await _storage.read(key: "user_id");

    print("🔑 Stored User ID: $id");

    if (id != null) {
      return int.tryParse(id);
    }
    return null;
  }

  Future<bool> isLoggedIn() async {
    String? userId = await _storage.read(key: "user_id");
    return userId != null;
  }

  Future<void> logout() async {
    await _storage.delete(key: "user_id");
  }
}

