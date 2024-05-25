import 'package:edu_diary/features/diary/domain/entity/lesson.dart';

class DiaryLessonModel extends DiaryLesson {
  DiaryLessonModel(
      super.lessonName,
      super.startTime,
      super.endTime,
      super.lessonNumber,
      super.topic,
      super.homework,
      super.previousHomework,
      super.teacherName,
      super.notes,
      super.marks);

  factory DiaryLessonModel.fromJson(Map<String, dynamic> json) {
    return DiaryLessonModel(
      json['SUBJECT_NAME'],
      json['LESSON_TIME_BEGIN'],
      json['LESSON_TIME_END'],
      json['LESSON_NUMBER'],
      json['TOPIC'],
      json['HOMEWORK'],
      json['HOMEWORK_PREVIOUS']?['HOMEWORK'],
      json['TEACHER_NAME'],
      List<String>.from(json['NOTES']),
      json['MARKS'].map<int>((e) => e['VALUE'] as int).toList()
    );
  }
}
