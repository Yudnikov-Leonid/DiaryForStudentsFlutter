import 'package:edu_diary/features/news/news_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:intl/intl.dart';

class NewsDetails extends StatelessWidget {
  const NewsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final NewsEntity news = ModalRoute.of(context)!.settings.arguments as NewsEntity;
    return Scaffold(
      appBar: AppBar(
        title: const Text('News details'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        color: Colors.white,
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              width: double.infinity,
              child: Image.network(news.imageUrl),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              DateFormat('yyyy.MM.dd kk:mm')
                  .format(DateTime.fromMillisecondsSinceEpoch(news.date)),
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              news.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
            ),
            HtmlWidget(news.content, textStyle: const TextStyle(fontSize: 16),)
          ]),
        ),
      ),
    );
  }
}
