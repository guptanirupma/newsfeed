import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/articleModel.dart';
import '../repository/article_reposi.dart';

final articleViewModelProvider = StateNotifierProvider<ArticleViewModel, AsyncValue<List<Article>>>(
        (ref) => ArticleViewModel(ArticleRepository()));

class ArticleViewModel extends StateNotifier<AsyncValue<List<Article>>> {
  final ArticleRepository _repository;

  ArticleViewModel(this._repository) : super(const AsyncLoading()) {
    fetchArticles();
  }

  Future<void> fetchArticles() async {
    try {
      final articles = await _repository.fetchArticles();
      state = AsyncValue.data(articles);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
