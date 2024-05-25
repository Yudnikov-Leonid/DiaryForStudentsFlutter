import 'package:edu_diary/features/diary/data/models/lesson.dart';

class DiaryResponse {
  final bool success;
  final String message;
  final List<DiaryLessonModel>? lessons;

  DiaryResponse(this.success, this.message, this.lessons);

  factory DiaryResponse.fromJson(Map<String, dynamic> json) {
    return DiaryResponse(
        json['success'],
        json['message'],
        json['success']
            ? json['data'].map<DiaryLessonModel>((e) => DiaryLessonModel.fromJson(e)).toList()
            : null);
  }
}
