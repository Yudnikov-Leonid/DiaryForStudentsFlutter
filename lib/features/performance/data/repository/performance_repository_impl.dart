import 'package:edu_diary/core/resources/data_state.dart';
import 'package:edu_diary/features/performance/data/data_sources/performance_data_source.dart';
import 'package:edu_diary/features/performance/data/models/final_response.dart';
import 'package:edu_diary/features/performance/data/models/lesson.dart';
import 'package:edu_diary/features/performance/domain/entities/lesson.dart';
import 'package:edu_diary/features/performance/domain/repository/performance_repository.dart';

class PerformanceRepositoryImpl implements PerformanceRepository {
  final PerformanceDataSource _dataSource;
  PerformanceRepositoryImpl(this._dataSource);

  Map<String, double> _cachedAverageMap = {};
  PerformanceFinalResponse? _cachedFinalResponse;
  List<(String, String)> _periods = [];

  @override
  Future<DataState<(List<LessonModel>, int)>> getLessons() async {
    try {
      if (_periods.isEmpty) {
        _periods = await _dataSource.getPeriods();
      }
      _cachedFinalResponse = await _dataSource.getFinalLessons();
      _cachedAverageMap.clear();
      _cachedFinalResponse!.lessons!.forEach((element) {
        _cachedAverageMap[element.name] = element.data[2 - 1].$1;
      });
      final list = await _dataSource.getLessons(_periods[2 - 1], _cachedAverageMap);
      return DataSuccess((list.lessons!, 2));
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<List<LessonEntity>>> changeQuarter(int newQuarter) async {
    try {
      _cachedAverageMap.clear();
      _cachedFinalResponse!.lessons!.forEach((element) {
        _cachedAverageMap[element.name] = element.data[newQuarter - 1].$1;
      });
      final list = await _dataSource.getLessons(_periods[newQuarter - 1], _cachedAverageMap);
      return DataSuccess(list.lessons!);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }
}
