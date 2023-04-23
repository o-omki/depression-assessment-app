import "dart:convert";
import "package:http/http.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";

class APIClient {
  static final APIClient _singleton = APIClient._internal();

  factory APIClient() {
    return _singleton;
  }

  APIClient._internal();

  final String _endPoint = dotenv.env["MONGODB_API_ENDPOINT"]!;
  final String _apiKey = dotenv.env["MONGODB_API_KEY"]!;

  Future<Map<String, dynamic>> get(String endPoint) async {
    final response = await http.get(
      Uri.parse(_endPoint),
      headers: {"x-api-key": _apiKey},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to get from MongoDB API.");
    }
  }

  Future<Map<String, dynamic>> post(String endPoint, dynamic data) async {
    final response = await http.post(
      Uri.parse(_endPoint),
      headers: {
        "Content-Type": "application/json",
        "x-api-key": _apiKey,
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return JsonDecode(response.body);
    } else {
      throw Exception("Failed to post data to MongoDB API.");
    }
  }
}