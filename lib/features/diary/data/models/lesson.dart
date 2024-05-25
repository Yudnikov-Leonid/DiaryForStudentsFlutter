import 'package:edu_diary/features/diary/domain/entity/lesson.dart';

class DiaryLessonModel extends DiaryLesson {
  DiaryLessonModel(
      super.lessonName, super.lessonNumber, super.topic, super.homework);

  factory DiaryLessonModel.fromJson(Map<String, dynamic> json) {
    return DiaryLessonModel(json['SUBJECT_NAME'], json['LESSON_NUMBER'],
        json['TOPIC'], json['HOMEWORK']);
  }
}
