import 'package:edu_diary/core/resources/data_state.dart';
import 'package:edu_diary/features/diary/data/data_sources/diary_data_source.dart';
import 'package:edu_diary/features/diary/data/models/response.dart';
import 'package:edu_diary/features/diary/domain/entity/lesson.dart';
import 'package:edu_diary/features/diary/domain/repository/diary_repository.dart';
import 'package:intl/intl.dart';

class DiaryRepositoryImpl implements DiaryRepository {
  final DiaryDataSource _dataSource;
  DiaryRepositoryImpl(this._dataSource);

  final Map<String, DiaryResponse> _cache = {};

  @override
  Future<DataState<List<DiaryLesson>>> lessons(String date) async {
    try {
      if (_cache[date] == null) {
        _cache[date] = await _dataSource.getDayLessons(date);
      }
      return DataSuccess(_cache[date]!.lessons!);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }
  
  @override
  String today() {
    return DateFormat('dd-MM-yyyy').format(DateTime.now());
  }
}
