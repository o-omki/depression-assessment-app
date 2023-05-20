import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import "package:flutter_dotenv/flutter_dotenv.dart";

String hostIp = dotenv.env["HOST_IP"]!;

Future<bool> checkUserExists(String userId) async {
  log(userId);
  String url = "$hostIp/serenity/users/$userId";

  // Send the GET request
  http.Response response = await http.get(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
  );

  log('Response: $response');

  if (response.statusCode == 404) {
    log("User not found");
    return false;
  } else {
    log("User found");
    return true;
  }
}

Future<Map<String, dynamic>> updateUserProfile(
    String userId, Map<String, dynamic> updatedProfile) async {
  String url = "$hostIp/serenity/users/$userId";

  http.Response response = await http.put(
    Uri.parse(url),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(updatedProfile),
  );

  if (response.statusCode == 200) {
    log("User profile updated successfully");
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    return jsonResponse;
  } else {
    log("Failed to update user profile");
    log(response.body);
    return {};
  }
}
