import 'package:edu_diary/features/diary/domain/entity/lesson.dart';

class DiaryDay {
  final String title;
  final (List<String>, List<String>, List<String>) dates;
  final int selectedDay;
  final List<DiaryLesson> lessons;

  DiaryDay(this.title, this.dates, this.selectedDay, this.lessons);
}
