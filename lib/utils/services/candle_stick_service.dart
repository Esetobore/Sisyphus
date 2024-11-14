import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:roqquassessment/utils/services/web_socket_service.dart';

import '../../constants/endpoints.dart';
import '../../data_models/candlesticks.dart';

class CryptoApiService {
  final WebSocketService _webSocketService;

  CryptoApiService(this._webSocketService);

  Future<List<CandleStickModel>> getCandlestickData({
    required String symbol,
    required String interval,
    int? endTime,
  }) async {
    final response = await http.get(
      Uri.parse(
        Endpoints.candlesticksUrl(
          symbol: symbol,
          interval: interval,
          endTime: endTime,
        ),
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((data) => CandleStickModel.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load candlestick data');
    }
  }

  Stream<CandleStickModel>? subscribeToCandlesticks(
      String symbol, String interval) {
    final wsUrl = '${Endpoints.baseUrl}/$symbol@kline_$interval';
    final stream = _webSocketService.connect(wsUrl);

    return stream?.map((data) {
      final jsonData = json.decode(data);
      final klineData = jsonData['k'];
      return CandleStickModel(
        time: DateTime.fromMillisecondsSinceEpoch(klineData['t']),
        open: double.parse(klineData['o']),
        high: double.parse(klineData['h']),
        low: double.parse(klineData['l']),
        close: double.parse(klineData['c']),
        volume: double.parse(klineData['v']),
      );
    });
  }

  void unsubscribe() {
    _webSocketService.disconnect();
  }
}
