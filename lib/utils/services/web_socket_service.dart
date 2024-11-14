import 'dart:async';

import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  WebSocketChannel? _channel;
  Timer? _reconnectionTimer;
  final Duration reconnectDelay;
  bool _isConnected = false;

  WebSocketService({
    this.reconnectDelay = const Duration(seconds: 5),
  });

  Stream<dynamic>? connect(String url) {
    try {
      _channel = WebSocketChannel.connect(Uri.parse(url));
      _isConnected = true;
      return _channel?.stream;
    } catch (e) {
      _isConnected = false;
      rethrow;
    }
  }

  void send(dynamic data) {
    if (_isConnected && _channel != null) {
      _channel!.sink.add(data);
    }
  }

  void disconnect() {
    _isConnected = false;
    _channel?.sink.close();
    _reconnectionTimer?.cancel();
  }

  bool get isConnected => _isConnected;
}
