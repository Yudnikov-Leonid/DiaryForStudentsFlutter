import 'package:edu_diary/core/resources/data_state.dart';
import 'package:edu_diary/core/usecase/usecase.dart';
import 'package:edu_diary/features/performance/domain/entities/lesson.dart';
import 'package:edu_diary/features/performance/domain/repository/performance_repository.dart';

class ChangeQuarterUseCase implements UseCase<DataState<List<LessonEntity>>, int?> {
  final PerformanceRepository _repository;
  ChangeQuarterUseCase(this._repository);

  @override
  Future<DataState<List<LessonEntity>>> call({int? params}) {
    return _repository.changeQuarter(params!);
  }
}