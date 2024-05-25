import 'package:edu_diary/core/resources/data_state.dart';
import 'package:edu_diary/features/diary/domain/entity/lesson.dart';

abstract class DiaryRepository {
  Future<DataState<List<DiaryLesson>>> lessons(String date);
  String today();
}
