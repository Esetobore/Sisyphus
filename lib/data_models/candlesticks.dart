class CandleStickModel {
  final DateTime time;
  final double open;
  final double high;
  final double low;
  final double close;
  final double volume;

  CandleStickModel({
    required this.time,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
  });

  factory CandleStickModel.fromJson(List<dynamic> json) {
    return CandleStickModel(
      time: DateTime.fromMillisecondsSinceEpoch(json[0] as int),
      open: double.parse(json[1].toString()),
      high: double.parse(json[2].toString()),
      low: double.parse(json[3].toString()),
      close: double.parse(json[4].toString()),
      volume: double.parse(json[5].toString()),
    );
  }
}
