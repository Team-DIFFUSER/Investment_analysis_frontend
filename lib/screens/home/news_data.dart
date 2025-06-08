class News {
  final String? stockCode;
  final String title;
  final String description;
  final String url;
  final DateTime pubDate;
  final String thumbnailUrl;

  News({
    this.stockCode,
    required this.title,
    required this.description,
    required this.url,
    required this.pubDate,
    required this.thumbnailUrl,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      pubDate: DateTime.parse(json['pubDate']),
      stockCode: json['stockCode'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }
}
