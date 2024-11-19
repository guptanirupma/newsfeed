import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_feed_app/view/newsDetailScreen.dart';
import 'package:news_feed_app/viewModal/article_view_modal.dart';



class NewsFeedScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articlesState = ref.watch(articleViewModelProvider);

    return Scaffold(
      appBar: AppBar(
          title: Text('News Feed App'),
      backgroundColor: Colors.blue,),
      body: articlesState.when(
        data: (articles) => ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            final article = articles[index];
            return ListTile(
              leading: CachedNetworkImage(
                imageUrl: article.imageUrl,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              title: Text(article.title,style: TextStyle(
                fontSize: 18, // Font size
                fontWeight: FontWeight.bold, // Bold text
                color: Colors.black, // Text color
              ),),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  Text("Time : ${article.timestamp.toString()}",
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsDetailScreen(article: article),
                ),
              ),
            );
          },
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
