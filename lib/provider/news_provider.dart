import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:front_end/screens/home/news_data.dart';

class NewsProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  final storage = const FlutterSecureStorage();

  List<News> _newsList = [];
  List<News> get newsList => _newsList;

  List<News> get recommendedNews =>
      _newsList.where((news) => news.stockCode != null).toList();

  List<News> get latestNews =>
      _newsList.where((news) => news.stockCode == null).toList()
        ..sort((a, b) => b.pubDate.compareTo(a.pubDate));

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchNews() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    const url = 'http://52.79.34.229/api/news';

    try {
      final jwt = await storage.read(key: 'jwt');
      if (jwt == null || jwt.isEmpty) {
        _errorMessage = "JWT 토큰이 없습니다. 로그인 상태를 확인해주세요.";
        _isLoading = false;
        notifyListeners();
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
        final List<dynamic> data = response.data;

        _newsList = data.map((item) => News.fromJson(item)).toList();
      } else {
        _errorMessage = "뉴스 조회 실패 - 상태코드: ${response.statusCode}";
      }
    } catch (e) {
      _errorMessage = "뉴스 조회 중 오류 발생: $e";
    }

    _isLoading = false;
    notifyListeners();
  }
}
