import 'package:edu_diary/core/resources/data_state.dart';
import 'package:edu_diary/core/usecase/usecase.dart';
import 'package:edu_diary/features/performance/domain/entities/final_lesson.dart';
import 'package:edu_diary/features/performance/domain/repository/performance_repository.dart';

class GetFinalLessonsUseCase
    implements UseCase<DataState<List<FinalLessonEntity>>, void> {
  final PerformanceRepository _performanceRepository;
  GetFinalLessonsUseCase(this._performanceRepository);

  @override
  Future<DataState<List<FinalLessonEntity>>> call({void params}) async {
    return _performanceRepository.getFinalLessons();
  }
}
