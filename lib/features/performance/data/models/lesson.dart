import 'package:edu_diary/features/performance/data/models/cached_mark.dart';
import 'package:edu_diary/features/performance/data/models/mark.dart';
import 'package:edu_diary/features/performance/domain/entities/lesson.dart';

class LessonModel extends LessonEntity {
  const LessonModel(super.lessonName, super.marks, super.average);

  factory LessonModel.fromJson(
      Map<String, dynamic> json, List<CachedMark> cachedMarks) {
    return LessonModel(
        json['SUBJECT_NAME'],
        json['MARKS']
            .map(
                (e) => MarkModel.fromJson(e, json['SUBJECT_NAME'], cachedMarks))
            .toList(),
        0);
  }
}
