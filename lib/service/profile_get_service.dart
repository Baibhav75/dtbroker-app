import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/prfile_model.dart';


class ProfileService {

  Future<ProfileModel?> fetchProfile(int userId) async {

    final url = Uri.parse(
        "https://niveshcore.com/api/profile/get/$userId");

    final response = await http.get(url);

    print("📡 Profile Response: ${response.body}");

    if (response.statusCode == 200) {
      return ProfileModel.fromJson(
          jsonDecode(response.body));
    }

    return null;
  }
}
