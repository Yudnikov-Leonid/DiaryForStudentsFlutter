import 'package:edu_diary/core/resources/data_state.dart';
import 'package:edu_diary/core/usecase/usecase.dart';
import 'package:edu_diary/features/analytics/domain/entity/average_progress.dart';
import 'package:edu_diary/features/analytics/domain/entity/marks_count.dart';
import 'package:edu_diary/features/analytics/domain/repository/analytics_repository.dart';

class LoadAnalyticsUseCase
    implements UseCase<(DataState<(AverageProgress, MarksCount)>, int quarter), (int, int)?> {
  final AnalyticsRepository _repository;
  LoadAnalyticsUseCase(this._repository);

  @override
  Future<(DataState<(AverageProgress, MarksCount)>, int quarter)> call({(int, int)? params}) async {
    final quarter = params!.$1 == -1 ? _repository.currentQuarter() : params.$1;
    final data = await _repository.analytics(quarter, params.$2);
    print(data);
    return (data, quarter);
  }
}
