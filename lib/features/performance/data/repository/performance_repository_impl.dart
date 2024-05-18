import 'package:edu_diary/core/resources/data_state.dart';
import 'package:edu_diary/features/performance/data/data_sources/performance_data_source.dart';
import 'package:edu_diary/features/performance/data/models/lesson.dart';
import 'package:edu_diary/features/performance/domain/repository/performance_repository.dart';

class PerformanceRepositoryImpl implements PerformanceRepository {
  final PerformanceDataSource _dataSource;
  PerformanceRepositoryImpl(this._dataSource);

  @override
  Future<DataState<List<LessonModel>>> getLessons() async {
    try {
      final list = await _dataSource.getLessons();
      return DataSuccess(list.lessons!);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }
}
