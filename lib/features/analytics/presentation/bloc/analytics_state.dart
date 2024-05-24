import 'package:edu_diary/features/analytics/domain/entity/average_progress.dart';

abstract class AnalyticsState {}

class AnalyticsLoadingState extends AnalyticsState {}

class AnalyticsFailState extends AnalyticsState {
  final String message;
  AnalyticsFailState(this.message);
}

class AnalyticsLoadedState extends AnalyticsState {
  final AverageProgress averageProgress;
  AnalyticsLoadedState(this.averageProgress);
}