import 'package:dio/dio.dart';
import 'package:edu_diary/features/performance/domain/entities/lesson.dart';
import 'package:equatable/equatable.dart';

abstract class PerformanceState extends Equatable {
  final List<LessonEntity>? lessons;
  final DioException? error;

  const PerformanceState({this.lessons, this.error});

  @override
  List<Object?> get props => [lessons, error];
}

class PerformanceLoading extends PerformanceState {
  const PerformanceLoading();
}

class PerformanceSuccess extends PerformanceState {
  const PerformanceSuccess(List<LessonEntity> lessons): super(lessons: lessons);
}

class PerformanceFailed extends PerformanceState {
  const PerformanceFailed(DioException error): super(error: error);
}