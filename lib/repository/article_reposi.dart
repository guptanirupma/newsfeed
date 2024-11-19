import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/articleModel.dart';


class ArticleRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Article>> fetchArticles() async {
    final snapshot = await _firestore
        .collection('articles')
        .orderBy('timestamp', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => Article.fromFirestore(doc.data(), doc.id))
        .toList();
  }
}
