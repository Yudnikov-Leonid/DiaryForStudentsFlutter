import 'package:edu_diary/features/news/news_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

class NewsDetails extends StatelessWidget {
  const NewsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final NewsEntity news =
        ModalRoute.of(context)!.settings.arguments as NewsEntity;
    return Scaffold(
      appBar: AppBar(
        title: const Text('News details'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              final text = '${news.title}\n\n${news.content}';
              await Share.share(text);
            },
            icon: const Icon(Icons.share_rounded),
          )
        ],
      ),
      body: Container(
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                DateFormat('yyyy.MM.dd kk:mm')
                    .format(DateTime.fromMillisecondsSinceEpoch(news.date)),
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                news.title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(news.content, style: const TextStyle(fontSize: 16),)
            )
          ]),
        ),
      ),
    );
  }
}
