import 'dart:io';

import 'package:edu_diary/core/resources/data_state.dart';
import 'package:edu_diary/features/diary/data/data_sources/diary_data_source.dart';
import 'package:edu_diary/features/diary/data/models/response.dart';
import 'package:edu_diary/features/diary/domain/entity/diary_day.dart';
import 'package:edu_diary/features/diary/domain/repository/diary_repository.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class DiaryRepositoryImpl implements DiaryRepository {
  final DiaryDataSource _dataSource;
  DiaryRepositoryImpl(this._dataSource);

  final Map<String, DiaryResponse> _cache = {};

  String _cachedDate = '';

  @override
  Future<DataState<DiaryDay>> lessons(String date) async {
    try {
      if (_cache[date] == null) {
        _cache[date] = await _dataSource.getDayLessons(date);
      }
      _cachedDate = date;
      String homeworks = '';
      String previousHomeworks = '';
      _cache[date]!.lessons!.forEach((lesson) {
        if (lesson.homework != null) {
          homeworks += '${lesson.lessonName}: ${lesson.homework}\n\n';
        }
        if (lesson.previousHomework?.isNotEmpty ?? false) {
          previousHomeworks +=
              '${lesson.lessonName}: ${lesson.previousHomework}\n\n';
        }
      });
      return DataSuccess(DiaryDay(
          DateFormat('MMMM yyyy').format(DateFormat('dd.MM.yyyy').parse(date)),
          _generateDates(date),
          DateFormat('dd.MM.yyyy').parse(date).weekday,
          _cache[date]!.lessons!,
          homeworks.trim(),
          previousHomeworks.trim()));
    } on ClientException catch (e) {
      return const DataFailed('No internet connection');
    } on SocketException catch (e) {
      return const DataFailed('No internet connection');
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  (List<String>, List<String>, List<String>) _generateDates(String today) {
    final formatter = DateFormat('dd.MM.yyyy');
    final dayOfTheWeek = formatter.parse(today).weekday;

    final currentList = [
      formatter.format(
          formatter.parse(today).add(Duration(days: -dayOfTheWeek + 1))),
      formatter.format(
          formatter.parse(today).add(Duration(days: -dayOfTheWeek + 2))),
      formatter.format(
          formatter.parse(today).add(Duration(days: -dayOfTheWeek + 3))),
      formatter.format(
          formatter.parse(today).add(Duration(days: -dayOfTheWeek + 4))),
      formatter.format(
          formatter.parse(today).add(Duration(days: -dayOfTheWeek + 5))),
      formatter.format(
          formatter.parse(today).add(Duration(days: -dayOfTheWeek + 6))),
      formatter.format(
          formatter.parse(today).add(Duration(days: -dayOfTheWeek + 7))),
    ];

    final nextList = [
      formatter.format(
          formatter.parse(today).add(Duration(days: -dayOfTheWeek + 8))),
      formatter.format(
          formatter.parse(today).add(Duration(days: -dayOfTheWeek + 9))),
      formatter.format(
          formatter.parse(today).add(Duration(days: -dayOfTheWeek + 10))),
      formatter.format(
          formatter.parse(today).add(Duration(days: -dayOfTheWeek + 11))),
      formatter.format(
          formatter.parse(today).add(Duration(days: -dayOfTheWeek + 12))),
      formatter.format(
          formatter.parse(today).add(Duration(days: -dayOfTheWeek + 13))),
      formatter.format(
          formatter.parse(today).add(Duration(days: -dayOfTheWeek + 14))),
    ];

    final previousList = [
      formatter.format(
          formatter.parse(today).add(Duration(days: -dayOfTheWeek - 6))),
      formatter.format(
          formatter.parse(today).add(Duration(days: -dayOfTheWeek - 5))),
      formatter.format(
          formatter.parse(today).add(Duration(days: -dayOfTheWeek - 4))),
      formatter.format(
          formatter.parse(today).add(Duration(days: -dayOfTheWeek - 3))),
      formatter.format(
          formatter.parse(today).add(Duration(days: -dayOfTheWeek - 2))),
      formatter.format(
          formatter.parse(today).add(Duration(days: -dayOfTheWeek - 1))),
      formatter
          .format(formatter.parse(today).add(Duration(days: -dayOfTheWeek))),
    ];

    return (previousList, currentList, nextList);
  }

  @override
  String today() {
    return DateFormat('dd.MM.yyyy').format(DateTime.now());
  }

  @override
  String cachedDate() => _cachedDate;
}
