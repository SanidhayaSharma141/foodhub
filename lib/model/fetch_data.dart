import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl = 'https://theoptimiz.com/restro/public/api';

  Future<Map<String, dynamic>> getRestaurants(double lat, double lng) async {
    final apiUrl = '$baseUrl/get_resturants';
    final requestBody = {'lat': lat, 'lng': lng};

    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode(requestBody),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
