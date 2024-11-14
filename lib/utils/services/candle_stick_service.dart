import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../data_models/candlesticks.dart';

class CandlestickService {
  static const String baseUrl = "wss://stream.binance.com:9443/ws";

  Future<List<CandlestickModel>> fetchCandlesticks({
    required String symbol,
    required String interval,
    int? endTime,
  }) async {
    final url = Uri.parse(
        "https://api.binance.com/api/v3/klines?symbol=$symbol&interval=$interval${endTime != null ? "&endTime=$endTime" : ""}");

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => CandlestickModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load candlesticks');
    }
  }

  String getCandlestickStreamUrl(String symbol, String interval) {
    return "$baseUrl/${symbol.toLowerCase()}@kline_$interval";
  }
}
