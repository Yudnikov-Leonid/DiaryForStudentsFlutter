import 'package:edu_diary/core/constants/marks_colors.dart';
import 'package:edu_diary/features/diary/domain/entity/lesson.dart';
import 'package:flutter/material.dart';

Widget diaryLessonWidget(DiaryLesson lesson, BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.pushNamed(context, '/lesson_details', arguments: lesson);
    },
    child: Container(
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
            '${lesson.startTime} - ${lesson.endTime}',
            style: const TextStyle(color: Colors.black45, fontWeight: FontWeight.bold),
          ),
          Text(
            "${lesson.lessonNumber}. ${lesson.lessonName}",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          lesson.topic == null
              ? const SizedBox()
              : const Text(
                  "Topic",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
          lesson.topic == null
              ? const SizedBox()
              : Text(
                  lesson.topic!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 16),
                ),
          lesson.homework == null
              ? const SizedBox()
              : const Text(
                  "Homework",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
          lesson.homework == null
              ? const SizedBox()
              : Text(
                  lesson.homework!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 16),
                ),
          lesson.marks.isEmpty
              ? const SizedBox()
              : SizedBox(
                  height: 20,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: lesson.marks.length,
                      itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: Text(
                              lesson.marks[index].toString(),
                              style: TextStyle(
                                  color: MarkColors.handleColor(
                                      lesson.marks[index])),
                            ),
                          )),
                )
        ],
      ),
    ),
  );
}
