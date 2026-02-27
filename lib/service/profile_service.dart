import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/prfile_model.dart';


class ProfileUpdateService {

  Future<bool> updateProfile(
      ProfileUpdateRequestModel request) async {

    final url = Uri.parse(
        "https://niveshcore.com/api/profile/update");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(request.toJson()),
    );

    print("📡 Update Response: ${response.body}");
    print("📤 Sending Update Body: ${jsonEncode(request.toJson())}");


    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }
}
