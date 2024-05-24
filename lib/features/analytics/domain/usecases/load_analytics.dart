import 'package:edu_diary/core/resources/data_state.dart';
import 'package:edu_diary/core/usecase/usecase.dart';
import 'package:edu_diary/features/analytics/domain/entity/average_progress.dart';
import 'package:edu_diary/features/analytics/domain/repository/analytics_repository.dart';

class LoadAnalyticsUseCase
    implements UseCase<(DataState<AverageProgress>, int), (int, int)?> {
  final AnalyticsRepository _repository;
  LoadAnalyticsUseCase(this._repository);

  @override
  Future<(DataState<AverageProgress>, int)> call({(int, int)? params}) async {
    return (await _repository.averageProgress(params!.$1, params.$2), 0);
  }
}
