import 'package:front_end/stockInfo/stock_information.dart';

final List<StockInfo> recommendedStockList = [
  StockInfo(
    symbol: 'NVDA',
    company: 'NVIDIA Corporation',
    price: 482.76,
    recommendation: 'Strong Buy',
  ),
  StockInfo(
    symbol: 'MSFT',
    company: 'Microsoft Corp.',
    price: 321.00,
    recommendation: 'Buy',
  ),
];

final List<StockInfo> trendStockList = [
  StockInfo(
    symbol: 'AAPL',
    company: 'Apple Inc.',
    price: 178.24,
    recommendation: '+2.45%',
  ),
  StockInfo(
    symbol: 'TSLA',
    company: 'Tesla Inc.',
    price: 720.50,
    recommendation: '+1.82%',
  ),
];
