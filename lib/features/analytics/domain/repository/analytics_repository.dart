import 'package:edu_diary/core/resources/data_state.dart';
import 'package:edu_diary/features/analytics/domain/entity/average_progress.dart';

abstract class AnalyticsRepository {
  Future<DataState<AverageProgress>> averageProgress(int quarter, int interval);
}