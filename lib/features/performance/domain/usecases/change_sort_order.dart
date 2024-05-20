import 'package:edu_diary/core/resources/data_state.dart';
import 'package:edu_diary/core/usecase/usecase.dart';
import 'package:edu_diary/features/performance/domain/entities/lesson.dart';
import 'package:edu_diary/features/performance/domain/repository/performance_repository.dart';

class ChangeSortOrderUseCase implements UseCase<DataState<(List<LessonEntity> list, int quarter, (int, int) settings)>, int?> {
  final PerformanceRepository _repository;
  ChangeSortOrderUseCase(this._repository);

  @override
  Future<DataState<(List<LessonEntity>, int, (int, int))>> call({int? params}) async {
    await _repository.changeSortOrder(params!);
    return _repository.getLessons();
  }
}