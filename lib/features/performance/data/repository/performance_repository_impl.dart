import 'package:edu_diary/core/resources/data_state.dart';
import 'package:edu_diary/features/performance/data/data_sources/performance_cloud_data_source.dart';
import 'package:edu_diary/features/performance/data/database/marks_db.dart';
import 'package:edu_diary/features/performance/data/models/cached_mark.dart';
import 'package:edu_diary/features/performance/data/models/final_response.dart';
import 'package:edu_diary/features/performance/data/models/lesson.dart';
import 'package:edu_diary/features/performance/data/models/response.dart';
import 'package:edu_diary/features/performance/domain/entities/final_lesson.dart';
import 'package:edu_diary/features/performance/domain/entities/lesson.dart';
import 'package:edu_diary/features/performance/domain/repository/performance_repository.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PerformanceRepositoryImpl implements PerformanceRepository {
  final PerformanceCloudDataSource _dataSource;
  final MarksDB _db;
  PerformanceRepositoryImpl(this._dataSource, this._db);

  final Map<String, double> _cachedAverageMap = {};
  PerformanceFinalResponse? _cachedFinalResponse;
  List<(String, String)> _periods = [];

  int _currentQuarter = 4;

  final Map<int, PerformanceResponse> _cache = {};

  @override
  List<(String, String)> periods() => _periods;

  @override
  Future<int> init() async {
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
    final cachedMarks = await _db.getList();
    if (_cache[_currentQuarter] == null) {
      _cache[_currentQuarter] = await _dataSource.getLessons(
          _periods[_currentQuarter - 1], _cachedAverageMap, cachedMarks);
    }
    var marksCount = 0;
    _cache[_currentQuarter]!.lessons!.forEach((e) {
      marksCount += e.marks.length;
    });
    final diff = marksCount - cachedMarks.length;
    if (diff >= 0) {
      return diff;
    } else {
      return 0;
    }
  }

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
        final cachedMarks = await _db.getList();
        _cache[_currentQuarter] = await _dataSource.getLessons(
            _periods[_currentQuarter - 1], _cachedAverageMap, cachedMarks);
      }
      await _db.clear();
      _cache[_currentQuarter]!.lessons!.forEach((lesson) {
        lesson.marks.forEach((mark) {
          _db.insert(
              mark: CachedMark(null, mark.date, lesson.lessonName, mark.value));
        });
      });
      return DataSuccess((
        await _applySettings(_cache[_currentQuarter]!.lessons!),
        _currentQuarter,
        (await _sortSettings(), await _sortOrderSettings())
      ));
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  Future<List<LessonModel>> _applySettings(List<LessonModel> list) async {
    List<LessonModel> newList = list;
    final sortType = await _sortSettings();
    if (sortType == 1) {
      newList.sort((a, b) => a.lessonName.compareTo(b.lessonName));
    } else if (sortType == 2) {
      newList.sort((a, b) => a.average.compareTo(b.average));
    } else {
      newList.sort((a, b) => a.marks.length.compareTo(b.marks.length));
    }
    if (await _sortOrderSettings() == 2) {
      newList = newList.reversed.toList();
    }
    return newList;
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
        _cache[newQuarter] = await _dataSource
            .getLessons(_periods[newQuarter - 1], _cachedAverageMap, []);
      }
      return DataSuccess((
        await _applySettings(_cache[_currentQuarter]!.lessons!),
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
