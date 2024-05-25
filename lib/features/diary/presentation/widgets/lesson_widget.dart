import 'package:edu_diary/features/diary/domain/entity/lesson.dart';
import 'package:flutter/material.dart';

Widget diaryLessonWidget(DiaryLesson lesson) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 2, spreadRadius: 2)
        ]),
    margin: const EdgeInsets.all(8),
    padding: const EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${lesson.lessonNumber}. ${lesson.lessonName}",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Text(
          "Topic",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          lesson.topic,
          style: const TextStyle(fontSize: 16),
        ),
        const Text(
          "Homework",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          lesson.homework,
          style: const TextStyle(fontSize: 16),
        )
      ],
    ),
  );
}
