class PriceData {
  final String currentPrice;
  final String highPrice;
  final String lowPrice;
  final String priceChange;
  final String priceChangePercent;
  final bool isPositiveChange;

  PriceData({
    required this.currentPrice,
    required this.highPrice,
    required this.lowPrice,
    required this.priceChange,
    required this.priceChangePercent,
    required this.isPositiveChange,
  });

  factory PriceData.initial() {
    return PriceData(
      currentPrice: "0.0",
      highPrice: "0.0",
      lowPrice: "0.0",
      priceChange: "0.0",
      priceChangePercent: "0.0%",
      isPositiveChange: true,
    );
  }

  factory PriceData.fromJson(Map<String, dynamic> json,
      {bool isWebSocket = false}) {
    if (isWebSocket) {
      return PriceData._fromWebSocket(json);
    }
    return PriceData._fromRest(json);
  }

  factory PriceData._fromWebSocket(Map<String, dynamic> data) {
    final priceChange = double.parse(data['p']);
    return PriceData(
      currentPrice: double.parse(data['c']).toStringAsFixed(2),
      highPrice: double.parse(data['h']).toStringAsFixed(2),
      lowPrice: double.parse(data['l']).toStringAsFixed(2),
      priceChange: priceChange.toStringAsFixed(2),
      priceChangePercent: '${double.parse(data['P']).toStringAsFixed(2)}%',
      isPositiveChange: priceChange >= 0,
    );
  }

  factory PriceData._fromRest(Map<String, dynamic> data) {
    final priceChange = double.parse(data['priceChange']);
    return PriceData(
      currentPrice: double.parse(data['lastPrice']).toStringAsFixed(2),
      highPrice: double.parse(data['highPrice']).toStringAsFixed(2),
      lowPrice: double.parse(data['lowPrice']).toStringAsFixed(2),
      priceChange: priceChange.toStringAsFixed(2),
      priceChangePercent:
          '${double.parse(data['priceChangePercent']).toStringAsFixed(2)}%',
      isPositiveChange: priceChange >= 0,
    );
  }
}
