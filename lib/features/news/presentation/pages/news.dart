import 'package:edu_diary/features/news/news_entity.dart';
import 'package:edu_diary/features/news/presentation/widgets/news_widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    DatabaseReference ref = FirebaseDatabase.instance.ref().child('news').ref;
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
        centerTitle: true,
      ),
      body: FirebaseAnimatedList(
        defaultChild: const Center(child: CircularProgressIndicator()),
        sort: (a, b) => int.parse(a.child('date').value.toString()) >
                int.parse(b.child('date').value.toString())
            ? -1
            : 1,
        query: ref,
        itemBuilder: (context, snapshot, index, animation) {
          return newsWidget(
              NewsEntity(
                  title: snapshot.child('title').value.toString(),
                  content: parseFragment(snapshot.child('content').value.toString().replaceAll('<br>', '\n'))
                          .text!,
                  date: int.parse(snapshot.child('date').value.toString()),
                  imageUrl: snapshot.child('photoUrl').value.toString()),
              context);
        },
      ),
    );
  }
}
