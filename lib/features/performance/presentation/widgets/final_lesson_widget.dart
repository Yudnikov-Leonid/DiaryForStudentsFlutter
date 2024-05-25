import 'package:edu_diary/core/constants/marks_colors.dart';
import 'package:edu_diary/features/performance/domain/entities/final_lesson.dart';
import 'package:flutter/material.dart';

class FinalLessonWidget extends StatelessWidget {
  const FinalLessonWidget(this._lesson, {super.key});

  final FinalLessonEntity _lesson;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _lesson.lessonName,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              _mark(_lesson.marks[0]),
              const SizedBox(
                width: 10,
              ),
              _mark(_lesson.marks[1]),
              const SizedBox(
                width: 10,
              ),
              _mark(_lesson.marks[2]),
              const SizedBox(
                width: 10,
              ),
              _mark(_lesson.marks[3]),
              const SizedBox(
                width: 10,
              ),
              _mark(_lesson.marks[4])
            ],
          )
        ],
      ),
    );
  }

  Widget _mark(int? mark) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: const BorderRadius.all(Radius.circular(52)),
          boxShadow: [
            BoxShadow(color: Colors.grey.shade200, spreadRadius: 2, blurRadius: 2)
          ]),
      child: Center(
        child: Text(
          mark?.toString() ?? '',
          style: TextStyle(
              color: MarkColors.handleColor(mark ?? 0),
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
