import 'package:flutter/material.dart';
import 'package:front_end/screens/home/news_data.dart';
import 'package:front_end/widgets/custom_bottom_navigation_bar.dart';
import 'package:front_end/widgets/custom_header.dart';
import 'package:timeago/timeago.dart' as timeago;

class LatestScreen extends StatefulWidget {
  final News news;

  const LatestScreen({super.key, required this.news});

  @override
  State<LatestScreen> createState() => _LatestScreenState();
}

class _LatestScreenState extends State<LatestScreen> {
  @override
  Widget build(BuildContext context) {
    final news = widget.news;

    return Scaffold(
      appBar: CustomHeader(
        showLogo: false,
        showUserIcon: true,
        showBackButton: true,
        title: "최신뉴스",
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  news.thumbnailUrl,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    news.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        timeago.format(news.pubDate, locale: 'ko'),
                        style: const TextStyle(color: Colors.grey),
                      ),
                      Text("출판사", style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(news.description, style: const TextStyle(fontSize: 16)),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 0),
    );
  }
}
