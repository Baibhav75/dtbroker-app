// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// import '../model/prfile_model.dart';
//
//
// class ProfileUpdateService {
//
//   Future<bool> updateProfile(
//       ProfileUpdateRequestModel request) async {
//
//     final url = Uri.parse(
//         "https://niveshcore.com/api/profile/update");
//
//     final response = await http.post(
//       url,
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode(request.toJson()),
//     );
//
//     print("📡 Update Response: ${response.body}");
//     print("📤 Sending Update Body: ${jsonEncode(request.toJson())}");
//
//
//     if (response.statusCode == 200) {
//       return true;
//     }
//
//     return false;
//   }
// }

import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/prfile_model.dart';
class ProfileService {
  final storage = const FlutterSecureStorage();

  /// GET PROFILE
  Future<ProfileModel> getProfile() async {
    final uniqueId = await storage.read(key: "unique_id");

    final url = Uri.parse(
        "https://niveshcore.com/api/user/get-profile?uniqueId=$uniqueId");

    final res = await http.get(url);

    if (res.statusCode == 200) {
      return ProfileModel.fromJson(jsonDecode(res.body));
    } else {
      throw Exception("Failed to load profile");
    }
  }

  /// UPDATE PROFILE (WITH IMAGE)
  Future<bool> updateProfile({
    required String name,
    required String email,
    required String mobile,
    required String state,
    required String city,
    required String address,
    required String pincode,
    File? image,
  }) async {
    final uniqueId = await storage.read(key: "unique_id");

    final request = http.MultipartRequest(
      'POST',
      Uri.parse(
          "https://niveshcore.com/api/user/edit-profile?uniqueId=$uniqueId"),
    );

    request.fields['Name'] = name;
    request.fields['Email'] = email;
    request.fields['MobileNumber'] = mobile;
    request.fields['State'] = state;
    request.fields['City'] = city;
    request.fields['Address'] = address;
    request.fields['Pincode'] = pincode;

    if (image != null) {
      request.files.add(
        await http.MultipartFile.fromPath("Profile", image.path),
      );
    }

    final response = await request.send();

    return response.statusCode == 200;
  }
}