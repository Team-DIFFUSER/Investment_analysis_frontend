import 'package:flutter/material.dart';
import 'package:front_end/provider/news_provider.dart';
import 'package:front_end/widgets/custom_bottom_navigation_bar.dart';
import 'package:front_end/widgets/custom_header.dart';
import 'package:front_end/widgets/custom_news_list.dart';
import 'package:provider/provider.dart';

class LatestListScreen extends StatefulWidget {
  const LatestListScreen({super.key});

  @override
  State<LatestListScreen> createState() => _LatestNewsScreenState();
}

class _LatestNewsScreenState extends State<LatestListScreen> {
  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);
    final latestNews = newsProvider.latestNews;
    return Scaffold(
      appBar: CustomHeader(
        showLogo: false,
        showUserIcon: true,
        showBackButton: true,
        title: "최신뉴스",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomNewsList(
                newsList: latestNews,
                onTap: (news) {
                  Navigator.pushNamed(context, '/latest', arguments: news);
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 0),
    );
  }
}
