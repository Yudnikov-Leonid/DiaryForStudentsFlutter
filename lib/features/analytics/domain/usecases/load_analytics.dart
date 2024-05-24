import 'package:edu_diary/core/resources/data_state.dart';
import 'package:edu_diary/core/usecase/usecase.dart';
import 'package:edu_diary/features/analytics/domain/entity/average_progress.dart';
import 'package:edu_diary/features/analytics/domain/repository/analytics_repository.dart';

class LoadAnalyticsUseCase
    implements UseCase<(DataState<AverageProgress>, int), void> {
  final AnalyticsRepository _repository;
  LoadAnalyticsUseCase(this._repository);

  @override
  Future<(DataState<AverageProgress>, int)> call({void params}) async {
    return (await _repository.averageProgress(7), 0);
  }
}
