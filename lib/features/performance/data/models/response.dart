import 'package:edu_diary/core/constants/marks_colors.dart';
import 'package:edu_diary/features/performance/data/models/cached_mark.dart';
import 'package:edu_diary/features/performance/data/models/lesson.dart';
import 'package:edu_diary/features/performance/data/models/mark.dart';
import 'package:flutter/material.dart';

class PerformanceResponse {
  final bool success;
  final String message;
  final List<LessonModel>? lessons;

  PerformanceResponse(
      {required this.success, required this.message, required this.lessons});

  factory PerformanceResponse.fromJson(Map<String, dynamic> json,
      Map<String, double> averages, List<CachedMark> cachedMarks) {
    return PerformanceResponse(
        success: json['success'],
        message: json['message'],
        lessons: json['success']
            ? json['data']
                .toList()
                .map<LessonModel>((lesson) => LessonModel(
                    lesson['JOURNAL_NAME'],
                    lesson['MARKS']
                        .map<MarkModel>((mark) => MarkModel.fromJsonShortDate(
                            mark, lesson['JOURNAL_NAME'], cachedMarks))
                        .toList(),
                    averages[lesson['JOURNAL_NAME']] == 0
                        ? _calculateAverage(lesson['MARKS']
                            .map<int>((e) => e['VALUE'] as int)
                            .toList())
                        : averages[lesson['JOURNAL_NAME']] ?? 0))
                .where((LessonModel it) => it.marks.isNotEmpty)
                .toList()
            : null);
  }

  static double _calculateAverage(List<int> marks) {
    if (marks.isEmpty) return 0;
    final average =
        (marks.reduce((a, b) => a + b) / marks.length * 100).round() / 100;
    return average;
  }

//TODO move public static methods
  static Color handleColor(int value) {
    switch (value) {
      case 5:
        return MarksColors.fiveColor;
      case 4:
        return MarksColors.fourColor;
      case 3:
        return MarksColors.threeColor;
      case 2:
        return MarksColors.twoColor;
      case 1:
        return MarksColors.oneColor;
      default:
        return Colors.black;
    }
  }

  static Color handleAverageColor(double value) {
    switch (value) {
      case >= 4.5:
        return MarksColors.fiveColor;
      case >= 3.5:
        return MarksColors.fourColor;
      case >= 2.5:
        return MarksColors.threeColor;
      case > 1:
        return MarksColors.twoColor;
      default:
        return MarksColors.oneColor;
    }
  }
}
