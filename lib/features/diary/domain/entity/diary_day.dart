import 'package:edu_diary/features/diary/domain/entity/lesson.dart';

class DiaryDay {
  final String title;
  final (List<String>, List<String>, List<String>) dates;
  final int selectedDay;
  final String date;
  final List<DiaryLesson> lessons;

  final String homeworkToShare;
  final String previousHomeworkToShare;

  DiaryDay(this.title, this.dates, this.selectedDay, this.lessons, this.date,
      this.homeworkToShare, this.previousHomeworkToShare);
}
