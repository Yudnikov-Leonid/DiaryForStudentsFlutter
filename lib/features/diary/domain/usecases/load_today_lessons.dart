import 'package:edu_diary/core/resources/data_state.dart';
import 'package:edu_diary/core/usecase/usecase.dart';
import 'package:edu_diary/features/diary/domain/entity/diary_day.dart';
import 'package:edu_diary/features/diary/domain/repository/diary_repository.dart';
import 'package:intl/intl.dart';

class LoadTodayLessonsUseCase
    implements UseCase<DataState<DiaryDay>, void> {
  final DiaryRepository _repository;
  LoadTodayLessonsUseCase(this._repository);

  @override
  Future<DataState<DiaryDay>> call({void params}) async {
    return await _repository.lessons(DateFormat('dd.MM.yyyy').format(DateTime.now()));
  }
}
