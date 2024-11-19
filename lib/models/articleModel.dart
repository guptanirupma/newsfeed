import 'package:cloud_firestore/cloud_firestore.dart';

class Article {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final DateTime timestamp;

  Article({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.timestamp,
  });

  factory Article.fromFirestore(Map<String, dynamic> data, String id) {
    return Article(
      id: id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }
}
