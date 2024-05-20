import 'package:edu_diary/core/resources/data_state.dart';
import 'package:edu_diary/features/performance/data/data_sources/performance_data_source.dart';
import 'package:edu_diary/features/performance/data/models/final_response.dart';
import 'package:edu_diary/features/performance/data/models/lesson.dart';
import 'package:edu_diary/features/performance/data/models/response.dart';
import 'package:edu_diary/features/performance/domain/entities/final_lesson.dart';
import 'package:edu_diary/features/performance/domain/entities/lesson.dart';
import 'package:edu_diary/features/performance/domain/repository/performance_repository.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PerformanceRepositoryImpl implements PerformanceRepository {
  final PerformanceDataSource _dataSource;
  PerformanceRepositoryImpl(this._dataSource);

  final Map<String, double> _cachedAverageMap = {};
  PerformanceFinalResponse? _cachedFinalResponse;
  List<(String, String)> _periods = [];

  int _currentQuarter = 4;

  final Map<int, PerformanceResponse> _cache = {};

  @override
  Future<DataState<(List<LessonModel>, int, (int, int))>> getLessons() async {
    try {
      if (_periods.isEmpty) {
        _periods = await _dataSource.getPeriods();
        final format = DateFormat('dd.MM.yyyy');
        final intPeriods = _periods
            .map((pair) => (
                  format.parse(pair.$1).millisecondsSinceEpoch ~/ 86400000,
                  format.parse(pair.$2).millisecondsSinceEpoch ~/ 86400000
                ))
            .toList();
        final today = DateTime.now().millisecondsSinceEpoch ~/ 86400000;
        for (int i = 0; i < 3; i++) {
          if (intPeriods[i].$1 > today && today < intPeriods[i + 1].$1) {
            _currentQuarter = i + 1;
            break;
          }
        }
      }
      _cachedFinalResponse ??= await _dataSource.getFinalLessons();
      _cachedAverageMap.clear();
      _cachedFinalResponse!.lessons!.forEach((element) {
        _cachedAverageMap[element.lessonName] =
            element.data[_currentQuarter - 1].$1;
      });
      if (_cache[_currentQuarter] == null) {
        _cache[_currentQuarter] = await _dataSource.getLessons(
            _periods[_currentQuarter - 1], _cachedAverageMap);
      }
      final sortType = await _sortSettings();
      List<LessonModel> sortedList = _cache[_currentQuarter]!.lessons!;
      if (sortType == 1) {
        sortedList.sort((a, b) => a.lessonName.compareTo(b.lessonName));
      } else if (sortType == 2) {
        sortedList.sort((a, b) => a.average.compareTo(b.average));
      } else {
        sortedList.sort((a, b) => a.marks.length.compareTo(b.marks.length));
      }
      if (await _sortOrderSettings() == 2) {
        sortedList = sortedList.reversed.toList();
      }
      return DataSuccess((
        sortedList,
        _currentQuarter,
        (await _sortSettings(), await _sortOrderSettings())
      ));
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<(List<LessonEntity>, (int, int))>> changeQuarter(
      int newQuarter) async {
    _currentQuarter = newQuarter;
    try {
      _cachedAverageMap.clear();
      _cachedFinalResponse!.lessons!.forEach((element) {
        _cachedAverageMap[element.lessonName] = element.data[newQuarter - 1].$1;
      });
      if (_cache[newQuarter] == null) {
        _cache[newQuarter] = await _dataSource.getLessons(
            _periods[newQuarter - 1], _cachedAverageMap);
      }
      return DataSuccess((
        _cache[newQuarter]!.lessons!,
        (await _sortSettings(), await _sortOrderSettings())
      ));
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  int currentQuarter() => _currentQuarter;

  @override
  DataState<List<FinalLessonEntity>> getFinalLessons() {
    if (_cachedFinalResponse != null) {
      return DataSuccess(_cachedFinalResponse!.lessons!);
    } else {
      return const DataFailed('No data');
    }
  }

  Future<int> _sortSettings() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getInt(sortKey) ?? 1;
  }

  Future<int> _sortOrderSettings() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getInt(sortOrderKey) ?? 1;
  }

  static const sortKey = 'SORT_SETTINGS';
  static const sortOrderKey = 'SORT_ORDER_SETTINGS';

  @override
  Future<void> changeSort(int newValue) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setInt(sortKey, newValue);
  }

  @override
  Future<void> changeSortOrder(int newValue) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setInt(sortOrderKey, newValue);
  }
}
