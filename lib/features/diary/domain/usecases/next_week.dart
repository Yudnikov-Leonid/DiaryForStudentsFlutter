import 'package:edu_diary/core/resources/data_state.dart';
import 'package:edu_diary/core/usecase/usecase.dart';
import 'package:edu_diary/features/diary/domain/entity/diary_day.dart';
import 'package:edu_diary/features/diary/domain/repository/diary_repository.dart';
import 'package:intl/intl.dart';

class NextWeekUseCase implements UseCase<DataState<DiaryDay>, void> {
  final DiaryRepository _repository;
  NextWeekUseCase(this._repository);

  @override
  Future<DataState<DiaryDay>> call({void params}) async {
    final formatter = DateFormat('dd.MM.yyyy');
    final nextWeek =
        formatter.parse(_repository.cachedDate()).add(const Duration(days: 7));
    return await _repository.lessons(formatter.format(nextWeek));
  }
}
