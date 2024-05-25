import 'package:edu_diary/features/analytics/domain/entity/average_progress.dart';
import 'package:edu_diary/features/analytics/domain/entity/marks_count.dart';
import 'package:edu_diary/features/analytics/domain/entity/marks_count_progress.dart';

abstract class AnalyticsState {}

class AnalyticsLoadingState extends AnalyticsState {}

class AnalyticsFailState extends AnalyticsState {
  final String message;
  AnalyticsFailState(this.message);
}

class AnalyticsLoadedState extends AnalyticsState {
  final AverageProgress averageProgress;
  final MarksCount marksCount;
  final MarksCountProgress marksCountProgress;
  final (int, int) settings;

  AnalyticsLoadedState(
      {required this.averageProgress,
      required this.marksCount,
      required this.marksCountProgress,
      required this.settings});
}
