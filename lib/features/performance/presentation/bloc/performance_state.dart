import 'package:edu_diary/features/performance/domain/entities/final_lesson.dart';
import 'package:edu_diary/features/performance/domain/entities/lesson.dart';
import 'package:equatable/equatable.dart';

abstract class PerformanceState extends Equatable {
  final List<LessonEntity>? lessons;
  final List<FinalLessonEntity>? finalLessons;
  final String? error;
  final int? quarter;

  const PerformanceState({this.lessons, this.finalLessons, this.error, this.quarter});

  @override
  List<Object?> get props => [lessons, error, quarter];
}

class PerformanceLoading extends PerformanceState {
  const PerformanceLoading();
}


class PerformanceSuccess extends PerformanceState {
  const PerformanceSuccess(List<LessonEntity> lessons, int quarter)
      : super(lessons: lessons, quarter: quarter);
}

class PerformanceFinalSuccess extends PerformanceState {
  const PerformanceFinalSuccess(List<FinalLessonEntity> lessons)
      : super(finalLessons: lessons);
}

class PerformanceFailed extends PerformanceState {
  const PerformanceFailed(String error) : super(error: error);
}
