import 'package:flutter/material.dart';
import 'package:front_end/stockInfo/stock_graph_information.dart';
import 'package:front_end/widgets/custom_bottom_navigation_bar.dart';
import 'package:front_end/widgets/custom_cardlist.dart';
import 'package:front_end/widgets/custom_graph.dart';
import 'package:front_end/widgets/custom_header.dart';
import 'package:front_end/stockInfo/stock_information.dart';
import 'package:front_end/stockInfo/stock_list.dart';
import 'package:front_end/stockInfo/stock_graph_list.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(
        showLogo: true,
        showUserIcon: true,
        showBackButton: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomGraph(
                symbol: "Market Overview",
                currentData: stockGraphList[0].currentData,
                predictedData: stockGraphList[0].predictedData,
              ),
              const SizedBox(height: 16),
              const Text(
                '추천사항',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              CustomCardlist(stockList: recommendedStockList),
              const SizedBox(height: 16),
              const Text(
                '투자 트랜드',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              CustomCardlist(stockList: trendStockList),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 1),
    );
  }
}
