import 'package:edu_diary/features/diary/domain/entity/diary_day.dart';

abstract class DiaryState {}

class DiaryLoadingState extends DiaryState {}

class DiaryLoadedState extends DiaryState {
  final (List<String>, List<String>, List<String>) dates;
  final String title;
  final int selectedDate;
  final DiaryDay day;

  DiaryLoadedState(this.title, this.dates, this.selectedDate, this.day);
}

class DiaryFailedState extends DiaryState {
  final String message;
  DiaryFailedState(this.message);
}
