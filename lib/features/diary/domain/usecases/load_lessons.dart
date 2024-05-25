import 'package:edu_diary/core/resources/data_state.dart';
import 'package:edu_diary/core/usecase/usecase.dart';
import 'package:edu_diary/features/diary/domain/entity/lesson.dart';
import 'package:edu_diary/features/diary/domain/repository/diary_repository.dart';

class LoadLessonsUseCase implements UseCase<DataState<List<DiaryLesson>>, String?> {
  final DiaryRepository _repository;
  LoadLessonsUseCase(this._repository);

  @override
  Future<DataState<List<DiaryLesson>>> call({String? params}) async {
    return await _repository.lessons(params!);
  }
}