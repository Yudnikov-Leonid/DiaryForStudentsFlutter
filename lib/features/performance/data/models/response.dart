import 'package:edu_diary/features/performance/data/models/cached_mark.dart';
import 'package:edu_diary/features/performance/data/models/lesson.dart';
import 'package:edu_diary/features/performance/data/models/mark.dart';

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
}
