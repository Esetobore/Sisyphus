import 'package:flutter/material.dart';
import 'package:roqquassessment/constants/image_path.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../controller/candlestick_controller.dart';
import '../../data_models/candlesticks.dart';
import '../../utils/services/candle_stick_service.dart';
import '../../utils/services/web_socket_service.dart';

// Add this enum at the top of your file, outside the class
enum TimeFrame {
  oneHour('1h'),
  twoHour('2h'),
  fourHour('4h'),
  oneDay('1d'),
  oneWeek('1w'),
  oneMonth('1M');

  final String interval;
  const TimeFrame(this.interval);
}

class ChartView extends StatefulWidget {
  const ChartView({super.key});

  @override
  State<ChartView> createState() => _ChartViewState();
}

class _ChartViewState extends State<ChartView> {
  late final ChartController _controller;
  TimeFrame _selectedTimeFrame = TimeFrame.oneDay;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = ChartController(
      CryptoApiService(WebSocketService()),
    );
    _controller.loadInitialData();
  }

  void _onTimeFrameChanged(TimeFrame timeFrame) async {
    setState(() {
      _selectedTimeFrame = timeFrame;
      _isLoading = true;
    });

    try {
      // This uses your existing controller method!
      _controller.changeInterval(timeFrame.interval);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update time frame: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Widget _buildTimeFrameButton(TimeFrame timeFrame) {
    final bool isSelected = _selectedTimeFrame == timeFrame;
    String label;

    switch (timeFrame) {
      case TimeFrame.oneHour:
        label = '1H';
      case TimeFrame.twoHour:
        label = '2H';
      case TimeFrame.fourHour:
        label = '4H';
      case TimeFrame.oneDay:
        label = '1D';
      case TimeFrame.oneWeek:
        label = '1W';
      case TimeFrame.oneMonth:
        label = '1M';
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: TextButton(
        onPressed: () => _onTimeFrameChanged(timeFrame),
        style: TextButton.styleFrom(
          backgroundColor: isSelected ? Colors.grey[300] : Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.grey[600],
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildTimeFrameSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Time"),
          _buildTimeFrameButton(TimeFrame.oneHour),
          _buildTimeFrameButton(TimeFrame.twoHour),
          _buildTimeFrameButton(TimeFrame.fourHour),
          _buildTimeFrameButton(TimeFrame.oneDay),
          _buildTimeFrameButton(TimeFrame.oneWeek),
          _buildTimeFrameButton(TimeFrame.oneMonth),
          Image.asset(ImagePaths.icCandleChart, height: 24, width: 24),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTimeFrameSelector(),
        SizedBox(
          height: 400,
          child: StreamBuilder<List<CandleStickModel>>(
            stream: _controller.candlesticksStream,
            builder: (context, snapshot) {
              if (_isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }

              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return SfCartesianChart(
                plotAreaBorderWidth: 0,
                primaryXAxis: const DateTimeAxis(
                  majorGridLines: MajorGridLines(width: 0),
                ),
                primaryYAxis: const NumericAxis(
                  axisLine: AxisLine(width: 0),
                  majorTickLines: MajorTickLines(size: 0),
                ),
                series: <CandleSeries<CandleStickModel, DateTime>>[
                  CandleSeries<CandleStickModel, DateTime>(
                    dataSource: snapshot.data!,
                    xValueMapper: (CandleStickModel sales, _) => sales.time,
                    lowValueMapper: (CandleStickModel sales, _) => sales.low,
                    highValueMapper: (CandleStickModel sales, _) => sales.high,
                    openValueMapper: (CandleStickModel sales, _) => sales.open,
                    closeValueMapper: (CandleStickModel sales, _) =>
                        sales.close,
                    bearColor: Colors.red,
                    bullColor: Colors.green,
                    enableSolidCandles: true,
                    enableTooltip: true,
                  ),
                ],
                zoomPanBehavior: ZoomPanBehavior(
                  enablePanning: true,
                  enablePinching: true,
                  enableDoubleTapZooming: true,
                ),
                crosshairBehavior: CrosshairBehavior(enable: true),
                trackballBehavior: TrackballBehavior(
                  enable: true,
                  activationMode: ActivationMode.singleTap,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
