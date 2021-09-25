import 'package:flutter/material.dart';
import '../model/news_model.dart';

class NewsImage extends StatelessWidget {
  final double height;
  final News news;
  const NewsImage({Key key, @required this.height, @required this.news})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: Colors.purple.shade50,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: news.imageUrl == null
          ? SizedBox(
              height: height,
              child: Placeholder(),
            )
          : Image.network(
              news.imageUrl ?? "",
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return SizedBox(
                  height: height,
                  child: Placeholder(),
                );
              },
            ),
    );
  }
}
