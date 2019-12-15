class News {
  String title = '';
  String type = '';
  String url = '';
  String by = '';
  int score = 0;

  News({this.title, this.type, this.url, this.by, this.score});

  factory News.fromJson(Map<String, dynamic> jsonMap) {
    return News(
      title: jsonMap['title'] ?? 'No Title Found',
      type: jsonMap['type'] ?? 'No Type Found',
      url: jsonMap['url'] ?? 'http://www.google.com',
      by: jsonMap['by'] ?? 'Author Not known',
      score: jsonMap['score'] ?? 0,
    );
  }
}
//'https://hacker-news.firebaseio.com/v0/item/$newsId.json'