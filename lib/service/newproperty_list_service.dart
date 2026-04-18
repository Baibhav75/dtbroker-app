import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../model/newproperty_list_model.dart';

class NewPropertyListService {
  static const String url =
      "https://niveshcore.com/api/property/list";

  Future<NewPropertyListModel> fetchProperties() async {
    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 15));

      print("STATUS CODE: ${response.statusCode}");
      print("RESPONSE: ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        return NewPropertyListModel.fromJson(jsonData);
      }

      // 🔴 Server error
      throw Exception("Server Error: ${response.statusCode}");

    } on SocketException {
      throw Exception("No Internet Connection");
    } on FormatException {
      throw Exception("Bad Response Format");
    } on HttpException {
      throw Exception("Couldn't find the data");
    } on Exception catch (e) {
      throw Exception("Something went wrong: $e");
    }
  }
}