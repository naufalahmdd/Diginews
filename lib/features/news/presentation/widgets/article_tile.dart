import 'package:flutter/material.dart';
import '../../domain/entities/article.dart';

class ArticleTile extends StatelessWidget {
  final Article article;

  const ArticleTile({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: article.urlToImage != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                article.urlToImage!,
                width: 56,
                height: 56,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
              ),
            )
          : const Icon(Icons.article, size: 40),
      title: Text(article.title, maxLines: 2, overflow: TextOverflow.ellipsis),
      subtitle: Text(article.sourceName),
    );
  }
}