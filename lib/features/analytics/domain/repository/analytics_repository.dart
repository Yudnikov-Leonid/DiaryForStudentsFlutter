import 'package:edu_diary/core/resources/data_state.dart';
import 'package:edu_diary/features/analytics/domain/entity/average_progress.dart';
import 'package:edu_diary/features/analytics/domain/entity/marks_count.dart';
import 'package:edu_diary/features/analytics/domain/entity/marks_count_progress.dart';

abstract class AnalyticsRepository {
  Future<DataState<(AverageProgress, MarksCount, MarksCountProgress)>>
      analytics(int quarter, int interval);
  int currentQuarter();
}
