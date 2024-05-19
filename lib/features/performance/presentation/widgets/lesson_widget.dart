import 'package:edu_diary/features/performance/data/models/response.dart';
import 'package:edu_diary/features/performance/domain/entities/lesson.dart';
import 'package:edu_diary/features/performance/domain/entities/mark.dart';
import 'package:flutter/material.dart';

class LessonWidget extends StatelessWidget {
  final LessonEntity lesson;

  const LessonWidget(this.lesson, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            lesson.lessonName,
            style: const TextStyle(fontSize: 20),
          ),
          SizedBox(height: 98, child: _marksList(lesson.marks)),
          Row(
            children: [
              const Text(
                'Average: ',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                lesson.average.toString(),
                style: TextStyle(
                    color: PerformanceResponse.handleAverageColor(lesson.average),
                    fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _marksList(List<MarkEntity> marks) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: marks.length,
        itemBuilder: (context, index) => Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(6),
              height: 30,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26.withAlpha(30),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(0, 0))
                  ]),
              child: Column(
                children: [
                  Text(
                    marks[index].date,
                    style: const TextStyle(fontSize: 12),
                  ),
                  Text(
                    marks[index].value.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                        color: PerformanceResponse.handleColor(marks[index].value)),
                  ),
                ],
              ),
            ));
  }
}
