class Article {
  String author;

  String title;

  String description;

  String url;

  String urlToImage;

  String publishedAt;

  String? content;

  Article({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    this.content,
  });

  factory Article.fromjson(Map<String, dynamic> json) {
    return Article(
      author: json['source']["name"],
      title: json['title'],
      description: json['description'],
      url: json['url'] ?? "",
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
    );
  }
}
