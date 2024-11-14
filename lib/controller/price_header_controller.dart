import 'dart:async';
import 'dart:convert';

import '../constants/endpoints.dart';
import '../data_models/price_data.dart';
import '../utils/services/price_service.dart';
import '../utils/services/web_socket_service.dart';

class PriceController {
  final WebSocketService _webSocketService;
  final PriceApiService _apiService;

  final _priceDataController = StreamController<PriceData>.broadcast();
  final _errorController = StreamController<String>.broadcast();

  String _currentSymbol;
  Timer? _healthCheckTimer;

  Stream<PriceData> get priceDataStream => _priceDataController.stream;
  Stream<String> get errorStream => _errorController.stream;

  PriceController({
    required WebSocketService webSocketService,
    required PriceApiService apiService,
    required String symbol,
  })  : _webSocketService = webSocketService,
        _apiService = apiService,
        _currentSymbol = symbol {
    _initializeHealthCheck();
  }

  Future<void> initialize() async {
    await _fetchInitialData();
    _setupWebSocketConnection();
  }

  Future<void> _fetchInitialData() async {
    try {
      final data = await _apiService.fetchInitialPrice(_currentSymbol);
      final priceData = PriceData.fromJson(data);
      _priceDataController.add(priceData);
    } catch (e) {
      _errorController.add('Error fetching initial data: $e');
    }
  }

  void _setupWebSocketConnection() {
    final stream = _webSocketService
        .connect('${Endpoints.baseUrl}/${_currentSymbol.toLowerCase()}@ticker');

    stream?.listen(
      (dynamic message) {
        try {
          final data = json.decode(message);
          final priceData = PriceData.fromJson(data, isWebSocket: true);
          _priceDataController.add(priceData);
        } catch (e) {
          _errorController.add('Error processing websocket data: $e');
        }
      },
      onError: (error) {
        _errorController.add('WebSocket Error: $error');
        _handleConnectionError();
      },
    );
  }

  void _handleConnectionError() {
    if (!_webSocketService.isConnected) {
      Future.delayed(const Duration(seconds: 5), () {
        _setupWebSocketConnection();
      });
    }
  }

  void _initializeHealthCheck() {
    _healthCheckTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (!_webSocketService.isConnected) {
        _setupWebSocketConnection();
      }
    });
  }

  Future<void> changeSymbol(String newSymbol) async {
    _currentSymbol = newSymbol;
    _webSocketService.disconnect();
    await initialize();
  }

  void dispose() {
    _webSocketService.disconnect();
    _apiService.dispose();
    _healthCheckTimer?.cancel();
    _priceDataController.close();
    _errorController.close();
  }
}
