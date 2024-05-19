import 'package:edu_diary/features/performance/domain/entities/final_lesson.dart';

class FinalLessonModel extends FinalLessonEntity {
  final List<(double average, int? value)> data;

  const FinalLessonModel(super.lessonName, super.marks, {required this.data});
}