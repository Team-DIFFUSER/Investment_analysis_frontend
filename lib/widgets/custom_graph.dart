import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomGraph extends StatelessWidget {
  final List<FlSpot> currentData;
  final List<FlSpot> predictedData;
  final String symbol;

  const CustomGraph({
    super.key,
    required this.currentData,
    required this.predictedData,
    required this.symbol,
  });

  List<Color> get gradientColors => [Color(0xFF6366F1), Color(0xFFD0D5E1)];
  List<Color> get predictedGradientColors => [
    Color(0xFF9E9E9E),
    Color(0xFF9E9E9E),
  ];

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(color: Colors.grey, fontSize: 12);
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    if (value.toInt() >= 0 && value.toInt() < days.length) {
      return SideTitleWidget(
        axisSide: meta.axisSide,
        space: 8,
        child: Text(days[value.toInt()], style: style),
      );
    }
    return const SizedBox.shrink();
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(color: Colors.grey, fontSize: 12);
    if (value % 300 == 0) {
      return Text(
        value.toInt().toString(),
        style: style,
        textAlign: TextAlign.right,
      );
    }
    return const SizedBox.shrink();
  }

  String getPercentageIncrease(double current, double previous) {
    double percentage = ((current - previous) / previous) * 100;
    return '${percentage.toStringAsFixed(2)}%';
  }

  @override
  Widget build(BuildContext context) {
    double lastActualValue = currentData.last.y;
    double previousValue = currentData[currentData.length - 2].y;
    String percentageIncrease = getPercentageIncrease(
      lastActualValue,
      previousValue,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      symbol,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      percentageIncrease,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w200,
                        color: Color(0xFF22C55E),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: false,
                          drawHorizontalLine: true,
                          getDrawingHorizontalLine:
                              (value) => const FlLine(
                                color: Colors.grey,
                                strokeWidth: 0.5,
                              ),
                        ),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval: 1,
                              getTitlesWidget: bottomTitleWidgets,
                              reservedSize: 32,
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval: 300,
                              getTitlesWidget: leftTitleWidgets,
                              reservedSize: 40,
                            ),
                          ),
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        borderData: FlBorderData(
                          show: true,
                          border: Border.all(color: Colors.grey),
                        ),
                        minX: 0,
                        maxX: 8,
                        minY: 0,
                        maxY: 1500,
                        lineBarsData: [
                          LineChartBarData(
                            spots: currentData,
                            isCurved: true,
                            color: const Color(0xff8284F4),
                            barWidth: 3,
                            isStrokeCapRound: true,
                            belowBarData: BarAreaData(
                              show: true,
                              gradient: LinearGradient(
                                colors:
                                    gradientColors
                                        .map((c) => c.withOpacity(0.2))
                                        .toList(),
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                          LineChartBarData(
                            spots: predictedData,
                            isCurved: true,
                            gradient: LinearGradient(
                              colors: predictedGradientColors,
                            ),
                            barWidth: 3,
                            isStrokeCapRound: true,
                            belowBarData: BarAreaData(
                              show: true,
                              gradient: LinearGradient(
                                colors:
                                    predictedGradientColors
                                        .map((c) => c.withOpacity(0.2))
                                        .toList(),
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
