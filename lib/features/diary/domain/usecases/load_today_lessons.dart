import 'package:edu_diary/core/resources/data_state.dart';
import 'package:edu_diary/core/usecase/usecase.dart';
import 'package:edu_diary/features/diary/domain/entity/lesson.dart';
import 'package:edu_diary/features/diary/domain/repository/diary_repository.dart';

class LoadTodayLessonsUseCase
    implements UseCase<DataState<List<DiaryLesson>>, void> {
  final DiaryRepository _repository;
  LoadTodayLessonsUseCase(this._repository);

  @override
  Future<DataState<List<DiaryLesson>>> call({void params}) async {
    return await _repository.lessons(_repository.today());
  }
}
