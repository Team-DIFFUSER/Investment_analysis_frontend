import 'package:front_end/stockInfo/stock_test_information.dart';

class AssetInfo {
  final String entr;
  final String d2EntBalance;
  final String totalEstimate;
  final String totalPurchase;
  final String lspftAmt;
  final String profitLoss;
  final String profitLossRate;
  final List<StockInfo> stocks;

  AssetInfo({
    required this.entr,
    required this.d2EntBalance,
    required this.totalEstimate,
    required this.totalPurchase,
    required this.lspftAmt,
    required this.profitLoss,
    required this.profitLossRate,
    required this.stocks,
  });

  factory AssetInfo.fromJson(Map<String, dynamic> json) {
    final stocksJson = json['stk_acnt_evlt_prst'] as List<dynamic>? ?? [];

    return AssetInfo(
      entr: json['entr'] ?? '',
      d2EntBalance: json['d2_entra'] ?? '',
      totalEstimate: json['tot_est_amt'] ?? '',
      totalPurchase: json['tot_pur_amt'] ?? '',
      lspftAmt: json['lspft_amt'] ?? '',
      profitLoss: json['lspft'] ?? '',
      profitLossRate: json['lspft_rt'] ?? '',
      stocks: stocksJson.map((e) => StockInfo.fromJson(e)).toList(),
    );
  }
}
