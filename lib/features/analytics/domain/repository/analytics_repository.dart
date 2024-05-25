import 'package:edu_diary/core/resources/data_state.dart';
import 'package:edu_diary/features/analytics/domain/entity/average_progress.dart';
import 'package:edu_diary/features/analytics/domain/entity/marks_count.dart';

abstract class AnalyticsRepository {
  Future<DataState<(AverageProgress, MarksCount)>> analytics(
      int quarter, int interval);
  int currentQuarter();
}
