import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:front_end/screens/loadmydata/asset_info.dart';
import 'package:front_end/stockInfo/stock_test_graph_information.dart';
import 'package:front_end/stockInfo/stock_test_information.dart';

class StockProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  final storage = const FlutterSecureStorage();

  List<StockGraphInfo> _graphDataList = [];
  List<StockInfo> _recommendedStockList = [];
  List<StockInfo> _trendStockList = [];

  AssetInfo? _assetInfo;
  Map<String, StockGraphInfo> _stockCharts = {};

  AssetInfo? get assetInfo => _assetInfo;
  Map<String, StockGraphInfo> get stockCharts => _stockCharts;

  List<StockGraphInfo> get graphDataList => _graphDataList;
  List<StockInfo> get recommendedStockList => _recommendedStockList;
  List<StockInfo> get trendStockList => _trendStockList;

  Future<void> fetchAllStockData() async {
    const url = 'http://52.79.34.229/api/assets';

    try {
      final jwt = await storage.read(key: 'jwt');
      if (jwt == null || jwt.isEmpty) {
        print("JWT 없음");
        return;
      }

      final response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $jwt',
            'Content-Type': 'application/json',
          },
        ),
      );

      print("응답 상태 코드: ${response.statusCode}");
      print("응답 데이터: ${response.data}");

      if (response.statusCode == 200) {
        final data =
            response.data is String ? jsonDecode(response.data) : response.data;

        final rawList = data['stk_acnt_evlt_prst'];
        if (rawList != null && rawList is List) {
          List<dynamic> stockList = rawList;
        } else {
          print("stk_acnt_evlt_prst 값이 null 이거나 리스트가 아님: $rawList");
        }

        _assetInfo = AssetInfo.fromJson(data);

        _graphDataList =
            (data['graphInfos'] != null && data['graphInfos'] is List)
                ? (data['graphInfos'] as List)
                    .map((e) => StockGraphInfo.fromJson(e))
                    .toList()
                : [];

        _recommendedStockList =
            (data['recommended'] != null && data['recommended'] is List)
                ? (data['recommended'] as List)
                    .map((e) => StockInfo.fromJson(e))
                    .toList()
                : [];

        _trendStockList =
            (data['trend'] != null && data['trend'] is List)
                ? (data['trend'] as List)
                    .map((e) => StockInfo.fromJson(e))
                    .toList()
                : [];

        final stocks = data['stk_acnt_evlt_prst'] as List;
        print("전체 종목 리스트:");
        for (var stock in stocks) {
          print('종목코드: ${stock['stk_cd']}, 종목명: ${stock['stk_nm']}');
        }
        print("response.data: ${response.data}");

        notifyListeners();
        print("자산 + 종목 데이터 모두 조회 성공");
      } else {
        print("전체 자산/종목 조회 실패 - 상태코드: ${response.statusCode}");
      }
    } catch (e) {
      print("전체 자산/종목 조회 중 오류 발생: $e");
    }
  }

  Future<void> fetchAssetInfo() async {
    const url = 'http://52.79.34.229/api/assets';

    try {
      final jwt = await storage.read(key: 'jwt');
      if (jwt == null || jwt.isEmpty) {
        print("JWT 없음");
        return;
      }

      final response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $jwt',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data =
            response.data is String ? jsonDecode(response.data) : response.data;
        _assetInfo = AssetInfo.fromJson(data);
        print("자산 평가 정보 조회 성공");
        notifyListeners();
      } else {
        print("자산 평가 조회 실패 - 상태코드: ${response.statusCode}");
      }
    } catch (e) {
      print("자산 평가 조회 중 오류 발생: $e");
    }
  }

  Future<void> fetchStockChart(String stkCd) async {
    final url = 'http://52.79.34.229/api/assets/$stkCd';

    try {
      final jwt = await storage.read(key: 'jwt');
      if (jwt == null || jwt.isEmpty) {
        print("JWT 없음");
        return;
      }

      final response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $jwt',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data =
            response.data is String ? jsonDecode(response.data) : response.data;
        final chartInfo = StockGraphInfo.fromJson(data);
        _stockCharts[stkCd] = chartInfo;
        print("종목 $stkCd 차트 정보 조회 성공");
        notifyListeners();
      } else {
        print("종목 $stkCd 차트 조회 실패 - 상태코드: ${response.statusCode}");
      }
    } catch (e) {
      print("종목 $stkCd 차트 조회 중 오류 발생: $e");
    }
  }

  void clearAllData() {
    _assetInfo = null;
    _stockCharts.clear();
    notifyListeners();
  }
}
