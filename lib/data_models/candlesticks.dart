class CandlestickModel {
  final DateTime timestamp;
  final double open;
  final double high;
  final double low;
  final double close;
  final double volume;

  CandlestickModel({
    required this.timestamp,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
  });

  factory CandlestickModel.fromJson(List<dynamic> json) {
    return CandlestickModel(
      timestamp: DateTime.fromMillisecondsSinceEpoch(json[0] as int),
      open: double.parse(json[1].toString()),
      high: double.parse(json[2].toString()),
      low: double.parse(json[3].toString()),
      close: double.parse(json[4].toString()),
      volume: double.parse(json[5].toString()),
    );
  }
}
