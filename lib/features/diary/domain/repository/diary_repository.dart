import 'package:edu_diary/core/resources/data_state.dart';
import 'package:edu_diary/features/diary/domain/entity/diary_day.dart';

abstract class DiaryRepository {
  Future<DataState<DiaryDay>> lessons(String date);
  String today();
}
