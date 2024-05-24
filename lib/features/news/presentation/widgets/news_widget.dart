import 'package:edu_diary/features/news/news_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

Widget newsWidget(NewsEntity news, BuildContext context) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    padding: const EdgeInsets.all(12),
    width: double.infinity,
    decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: const BorderRadius.all(Radius.circular(16))),
    child: InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/news_details', arguments: news);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 190,
            width: double.infinity,
            child: Image.network(news.imageUrl),
          ),
          const SizedBox(
            height: 5,
          ),
          Center(
            child: Text(
              news.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 80),
              child: HtmlWidget(news.content)),
          const SizedBox(
            height: 8,
          ),
          Text(
            _handleTimeAgo(news.date ~/ 1000),
            style: const TextStyle(fontSize: 13, color: Colors.grey),
          ),
        ],
      ),
    ),
  );
}

String _handleTimeAgo(int date) {
  final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  if (now - 60 < date) {
    return '${now - date} seconds ago';
  } else if (now - 3600 < date) {
    return '${(now - date) ~/ 60} minutes ago';
  } else if (now - 86400 < date) {
    return '${(now - date) / 3600} hours ago';
  } else if (now - 2592000 < date) {
    return '${(now - date) ~/ 86400} days ago';
  } else {
    return '${(now - date) ~/ 2592000} mounts ago';
  }
}
