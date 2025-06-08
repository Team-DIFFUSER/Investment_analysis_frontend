import 'package:fl_chart/fl_chart.dart';

class StockGraphInfo {
  final String stkCd;
  final String name;
  final List<FlSpot> currentPriceData;
  final List<FlSpot> predictedPriceData;

  StockGraphInfo({
    required this.stkCd,
    required this.name,
    required this.currentPriceData,
    required this.predictedPriceData,
  });

  factory StockGraphInfo.fromJson(Map<String, dynamic> json) {
    final rawCurrent = json['currentPriceData'] as List?;
    final rawPredicted = json['predictedPriceData'] as List?;

    final current =
        (rawCurrent ?? [])
            .map(
              (e) => FlSpot((e[0] as num).toDouble(), (e[1] as num).toDouble()),
            )
            .toList();

    final offsetX = current.isNotEmpty ? current.last.x + 1 : 0;

    final predicted =
        (rawPredicted ?? [])
            .map(
              (e) => FlSpot(
                offsetX + (e[0] as num).toDouble(),
                (e[1] as num).toDouble(),
              ),
            )
            .toList();

    return StockGraphInfo(
      stkCd: json['stk_cd'] ?? '',
      name: json['stk_nm'] ?? '',
      currentPriceData: current,
      predictedPriceData: predicted,
    );
  }
}
