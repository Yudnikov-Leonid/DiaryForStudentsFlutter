import 'package:edu_diary/core/resources/data_state.dart';
import 'package:edu_diary/features/diary/data/data_sources/diary_data_source.dart';
import 'package:edu_diary/features/diary/data/models/response.dart';
import 'package:edu_diary/features/diary/domain/entity/diary_day.dart';
import 'package:edu_diary/features/diary/domain/entity/lesson.dart';
import 'package:edu_diary/features/diary/domain/repository/diary_repository.dart';
import 'package:intl/intl.dart';

class DiaryRepositoryImpl implements DiaryRepository {
  final DiaryDataSource _dataSource;
  DiaryRepositoryImpl(this._dataSource);

  final Map<String, DiaryResponse> _cache = {};

  @override
  Future<DataState<DiaryDay>> lessons(String date) async {
    try {
      if (_cache[date] == null) {
        _cache[date] = await _dataSource.getDayLessons(date);
      }
      return DataSuccess(DiaryDay(
          '',
          _generateDates(),
          DateFormat('dd-MM-yyyy').parse(date).weekday,
          _cache[date]!.lessons!));
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  (List<String>, List<String>, List<String>) _generateDates() {
    final dayOfTheWeek = DateTime.now().weekday;
    final formatter = DateFormat('dd-MM-yyyy');

    final currentList = [
      formatter.format(DateTime.now().add(Duration(days: -dayOfTheWeek + 1))),
      formatter.format(DateTime.now().add(Duration(days: -dayOfTheWeek + 2))),
      formatter.format(DateTime.now().add(Duration(days: -dayOfTheWeek + 3))),
      formatter.format(DateTime.now().add(Duration(days: -dayOfTheWeek + 4))),
      formatter.format(DateTime.now().add(Duration(days: -dayOfTheWeek + 5))),
      formatter.format(DateTime.now().add(Duration(days: -dayOfTheWeek + 6))),
      formatter.format(DateTime.now().add(Duration(days: -dayOfTheWeek + 7))),
    ];

    final nextList = [
      formatter.format(DateTime.now().add(Duration(days: -dayOfTheWeek + 8))),
      formatter.format(DateTime.now().add(Duration(days: -dayOfTheWeek + 9))),
      formatter.format(DateTime.now().add(Duration(days: -dayOfTheWeek + 10))),
      formatter.format(DateTime.now().add(Duration(days: -dayOfTheWeek + 11))),
      formatter.format(DateTime.now().add(Duration(days: -dayOfTheWeek + 12))),
      formatter.format(DateTime.now().add(Duration(days: -dayOfTheWeek + 13))),
      formatter.format(DateTime.now().add(Duration(days: -dayOfTheWeek + 14))),
    ];

    final previousList = [
      formatter.format(DateTime.now().add(Duration(days: -dayOfTheWeek - 6))),
      formatter.format(DateTime.now().add(Duration(days: -dayOfTheWeek - 5))),
      formatter.format(DateTime.now().add(Duration(days: -dayOfTheWeek - 4))),
      formatter.format(DateTime.now().add(Duration(days: -dayOfTheWeek - 3))),
      formatter.format(DateTime.now().add(Duration(days: -dayOfTheWeek - 2))),
      formatter.format(DateTime.now().add(Duration(days: -dayOfTheWeek - 1))),
      formatter.format(DateTime.now().add(Duration(days: -dayOfTheWeek))),
    ];

    return (previousList, currentList, nextList);
  }

  @override
  String today() {
    return DateFormat('dd-MM-yyyy').format(DateTime.now());
  }
}
