import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:front_end/provider/user_provider.dart';
import 'package:front_end/userInfo/invest_information.dart';
import 'package:front_end/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class ResultScreen extends StatelessWidget {
  final InvestInformation result;
  ResultScreen({Key? key, required this.result}) : super(key: key);

  final Map<String, Color> typeColors = {
    '안정형': Colors.blue[100]!,
    '안정추구형': Colors.blue,
    '위험중립형': Colors.blue[700]!,
    '적극투자형': Colors.blue[800]!,
    '공격투자형': Colors.black,
  };

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.setInvestInfo(result);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.blue,
                padding: const EdgeInsets.only(top: 40, bottom: 8),
                child: Center(
                  child: Text(
                    "투자 성향 테스트 결과(${result.totalScore.toStringAsFixed(1)}점)",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              Container(
                color: Colors.blue,
                child: Center(
                  child: Text(
                    "당신의 성향은 「${result.investmentType}」입니다.",
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                padding: const EdgeInsets.only(bottom: 40),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "투자성향 분류기준",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 24),
                    _buildBarChart(result.investmentType),
                    const Text(
                      "안정형",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text("15점이하", textAlign: TextAlign.left),
                    const SizedBox(height: 8),
                    const Text(
                      "안정추구형",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text("16점 초과 20점이하", textAlign: TextAlign.left),
                    const SizedBox(height: 8),
                    const Text(
                      "위험중립형",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text("21점초과 25점이하", textAlign: TextAlign.left),
                    const SizedBox(height: 8),
                    const Text(
                      "적극투자형",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text("26점 초과 30점 이하", textAlign: TextAlign.left),
                    const SizedBox(height: 8),
                    const Text(
                      "공격투자형",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text("31점 이상", textAlign: TextAlign.left),
                    const SizedBox(height: 24),
                    const Text(
                      "당신의 투자성향",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 24),
                    _buildInvestmentTypeChart(result.totalScore),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildBarChart(String type) {
    final barData = [
      MapEntry('안정형', 15.0),
      MapEntry('안정추구형', 20.0),
      MapEntry('위험중립형', 25.0),
      MapEntry('적극투자형', 30.0),
      MapEntry('공격투자형', 35.0),
    ];

    return AspectRatio(
      aspectRatio: 1.3,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 40,
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 30),
            ),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    space: 8,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        barData[value.toInt()].key,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.visible,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
                reservedSize: 50,
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          barGroups:
              barData.asMap().entries.map((entry) {
                final index = entry.key;
                final e = entry.value;
                final isUserType = e.key == type;

                return BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      toY: e.value,
                      color: typeColors[e.key]!,
                      borderRadius: BorderRadius.circular(4),
                      width: 20,
                    ),
                  ],
                );
              }).toList(),
        ),
      ),
    );
  }

  Widget _buildInvestmentTypeChart(double userScore) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 130,
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 40),
            ),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      '${result.investmentType}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      softWrap: false,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                    ),
                  );
                },
                reservedSize: 50,
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          barGroups: [
            BarChartGroupData(
              x: 0,
              barRods: [
                BarChartRodData(
                  toY: userScore,
                  color: typeColors[result.investmentType],
                  borderRadius: BorderRadius.circular(4),
                  width: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 47,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/survey',
                    (route) => false,
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFD1D5DB), width: 1),
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xff374151),
                  textStyle: const TextStyle(fontWeight: FontWeight.w600),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("재설문"),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: SizedBox(
              height: 47,
              child: CustomButton(
                text: "결과 적용",
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
