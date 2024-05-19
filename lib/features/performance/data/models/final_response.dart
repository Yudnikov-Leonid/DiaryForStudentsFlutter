import 'package:edu_diary/features/performance/data/models/final_lesson.dart';

class PerformanceFinalResponse {
  final bool success;
  final String message;
  final List<FinalLessonModel>? lessons;

  PerformanceFinalResponse(
      {required this.success, required this.message, required this.lessons});

  factory PerformanceFinalResponse.fromJson(Map<String, dynamic> json) {
    return PerformanceFinalResponse(
        success: json['success'],
        message: json['message'],
        lessons: json['success']
            ? json['data']
                .toList()
                .map<FinalLessonModel>((lesson) => FinalLessonModel(
                    name: lesson['NAME'],
                    data: lesson['PERIODS']
                        .map<(double, int?)>((period) => (
                              period['AVERAGE'].toDouble() as double,
                              period['MARK']?['VALUE'] as int?
                            ))
                        .toList()))
                .toList()
            : null);
  }
}