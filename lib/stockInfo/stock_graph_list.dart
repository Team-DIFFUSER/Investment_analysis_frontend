import 'package:fl_chart/fl_chart.dart';

final List<FlSpot> stockCurrentData = [
  FlSpot(0, 500),
  FlSpot(1, 800),
  FlSpot(2, 400),
  FlSpot(3, 1000),
  FlSpot(4, 700),
  FlSpot(5, 1200),
  FlSpot(6, 900),
];

final List<FlSpot> stockPredictedData = [
  FlSpot(7, stockCurrentData.last.y),
  FlSpot(8, 1000),
];
