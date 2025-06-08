import 'package:flutter/material.dart';
import 'package:front_end/stockInfo/stock_graph_information.dart';
import 'package:front_end/widgets/custom_bottom_navigation_bar.dart';
import 'package:front_end/widgets/custom_graph.dart';
import 'package:front_end/widgets/custom_header.dart';
import 'package:front_end/stockInfo/stock_graph_list.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<MarketScreen> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredList =
        stockGraphList.where((stock) {
          return stock.symbol.toLowerCase().contains(searchQuery.toLowerCase());
        }).toList();

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
              SearchBarTheme(
                data: SearchBarThemeData(
                  side: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.focused)) {
                      return const BorderSide(
                        color: Color(0xFF3578FF),
                        width: 1.5,
                      );
                    }
                    return const BorderSide(color: Colors.transparent);
                  }),
                ),
                child: SearchBar(
                  leading: const Icon(Icons.search),
                  backgroundColor: const MaterialStatePropertyAll(Colors.white),
                  overlayColor: const MaterialStatePropertyAll(Colors.white),
                  shape: MaterialStateProperty.all(
                    ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  hintText: "종목 검색",
                  onSubmitted: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 16),

              if (searchQuery.isEmpty)
                Column(
                  children:
                      stockGraphList.take(5).map((stock) {
                        return Column(
                          children: [
                            CustomGraph(
                              symbol: stock.symbol,
                              currentData: stock.currentData,
                              predictedData: stock.predictedData,
                            ),
                            const SizedBox(height: 16),
                          ],
                        );
                      }).toList(),
                ),

              if (searchQuery.isNotEmpty)
                Column(
                  children: [
                    const SizedBox(height: 16),
                    if (filteredList.isNotEmpty)
                      ...filteredList.take(5).map((stock) {
                        return Column(
                          children: [
                            CustomGraph(
                              symbol: stock.symbol,
                              currentData: stock.currentData,
                              predictedData: stock.predictedData,
                            ),
                            const SizedBox(height: 16),
                          ],
                        );
                      }).toList()
                    else
                      const Text("검색된 종목이 없습니다."),
                  ],
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 2),
    );
  }
}
