import 'package:edu_diary/core/resources/data_state.dart';
import 'package:edu_diary/core/usecase/usecase.dart';
import 'package:edu_diary/features/performance/domain/entities/lesson.dart';
import 'package:edu_diary/features/performance/domain/repository/performance_repository.dart';

class GetLessonsUseCase
    implements UseCase<DataState<(List<LessonEntity> list, int quarter, (int, int) settings)>, void> {
  final PerformanceRepository _performanceRepository;
  GetLessonsUseCase(this._performanceRepository);

  @override
  Future<DataState<(List<LessonEntity> list, int quarter, (int, int) settings)>>
      call({void params}) {
    return _performanceRepository.getLessons();
  }
}
