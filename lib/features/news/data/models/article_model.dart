class ArticleModel {
  final String title;
  final String description;
  final String urlToImage;
  final String author;

  ArticleModel({
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.author,
  });

  // Fungsi untuk konversi dari JSON API ke Objek Dart
  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      urlToImage: json['urlToImage'] ?? '',
      author: json['author'] ?? 'Unknown Author',
    );
  }
}