import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final _baseUrl = 'https://rickandmortyapi.com/api';

  Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/$endpoint'));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 404) {
        throw Exception('Not found');
      } else if (response.statusCode == 500) {
        throw Exception('Internal server error');
      } else {
        throw Exception('Unknown error occurred while loading data');
      }
    } on SocketException {
      throw Exception('No internet connection. Please try again later.');
    }
  }
}
