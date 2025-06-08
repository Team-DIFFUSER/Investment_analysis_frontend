class StockInfo {
  final String stkCd;
  final String name;
  final double currentPrice;
  final String plRate;

  StockInfo({
    required this.stkCd,
    required this.name,
    required this.currentPrice,
    required this.plRate,
  });

  factory StockInfo.fromJson(Map<String, dynamic> json) {
    return StockInfo(
      stkCd: json['stk_cd'] as String,
      name: json['stk_nm'] as String,
      currentPrice: double.parse(json['cur_prc']),
      plRate: json['pl_rt']?.toString() ?? '0.0',
    );
  }
}
