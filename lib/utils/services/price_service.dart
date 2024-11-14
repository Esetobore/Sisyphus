import 'dart:convert';

import 'package:http/http.dart' as http;

class PriceApiService {
  final String baseUrl;
  final http.Client _client;

  PriceApiService({
    required this.baseUrl,
    http.Client? client,
  }) : _client = client ?? http.Client();

  Future<Map<String, dynamic>> fetchInitialPrice(String symbol) async {
    final response = await _client.get(
      Uri.parse('$baseUrl/api/v3/ticker/24hr?symbol=$symbol'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to fetch initial price data');
  }

  void dispose() {
    _client.close();
  }
}
