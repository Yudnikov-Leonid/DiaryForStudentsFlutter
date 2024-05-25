import 'package:edu_diary/features/diary/domain/entity/lesson.dart';

abstract class DiaryState {}

class DiaryLoadingState extends DiaryState {}

class DiaryLoadedState extends DiaryState {
  final (List<String>, List<String>, List<String>) dates;
  final String title;
  final int selectedDate;
  final String date;
  final List<DiaryLesson> lessons;

  DiaryLoadedState(this.title, this.dates, this.selectedDate, this.date, this.lessons);
}

class DiaryFailedState extends DiaryState {
  final String message;
  DiaryFailedState(this.message);
}
