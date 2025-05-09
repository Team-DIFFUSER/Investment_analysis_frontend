import 'package:fl_chart/fl_chart.dart';

class StockGraphInfo {
  final String symbol;
  final List<FlSpot> currentData;
  final List<FlSpot> predictedData;

  StockGraphInfo({
    required this.symbol,
    required this.currentData,
    required this.predictedData,
  });
}

final List<StockGraphInfo> stockGraphList = [
  StockGraphInfo(
    symbol: 'NVDA',
    currentData: [
      FlSpot(0, 500),
      FlSpot(1, 800),
      FlSpot(2, 400),
      FlSpot(3, 1000),
      FlSpot(4, 700),
      FlSpot(5, 1200),
      FlSpot(6, 900),
    ],
    predictedData: [FlSpot(7, 900), FlSpot(8, 1000)],
  ),
  StockGraphInfo(
    symbol: 'MSFT',
    currentData: [
      FlSpot(0, 300),
      FlSpot(1, 400),
      FlSpot(2, 600),
      FlSpot(3, 500),
      FlSpot(4, 700),
      FlSpot(5, 900),
      FlSpot(6, 800),
    ],
    predictedData: [FlSpot(7, 950), FlSpot(8, 1100)],
  ),
  StockGraphInfo(
    symbol: 'AAPL',
    currentData: [
      FlSpot(0, 100),
      FlSpot(1, 200),
      FlSpot(2, 300),
      FlSpot(3, 350),
      FlSpot(4, 500),
      FlSpot(5, 600),
      FlSpot(6, 700),
    ],
    predictedData: [FlSpot(7, 800), FlSpot(8, 850)],
  ),
  StockGraphInfo(
    symbol: 'TSLA',
    currentData: [
      FlSpot(0, 600),
      FlSpot(1, 700),
      FlSpot(2, 800),
      FlSpot(3, 850),
      FlSpot(4, 900),
      FlSpot(5, 1000),
      FlSpot(6, 1100),
    ],
    predictedData: [FlSpot(7, 1200), FlSpot(8, 1300)],
  ),
  StockGraphInfo(
    symbol: 'GOOG',
    currentData: [
      FlSpot(0, 1500),
      FlSpot(1, 1500),
      FlSpot(2, 1500),
      FlSpot(3, 1500),
      FlSpot(4, 1500),
      FlSpot(5, 1500),
      FlSpot(6, 1500),
    ],
    predictedData: [FlSpot(7, 1500), FlSpot(8, 1500)],
  ),
  StockGraphInfo(
    symbol: 'AMZN',
    currentData: [
      FlSpot(0, 1500),
      FlSpot(1, 1500),
      FlSpot(2, 1500),
      FlSpot(3, 1500),
      FlSpot(4, 1500),
      FlSpot(5, 1500),
      FlSpot(6, 1500),
    ],
    predictedData: [FlSpot(7, 1500), FlSpot(8, 1500)],
  ),
  StockGraphInfo(
    symbol: 'META',
    currentData: [
      FlSpot(0, 250),
      FlSpot(1, 300),
      FlSpot(2, 400),
      FlSpot(3, 350),
      FlSpot(4, 450),
      FlSpot(5, 500),
      FlSpot(6, 600),
    ],
    predictedData: [FlSpot(7, 650), FlSpot(8, 700)],
  ),
];
