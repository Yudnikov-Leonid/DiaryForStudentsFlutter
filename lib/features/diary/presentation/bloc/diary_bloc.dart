import 'package:edu_diary/core/resources/data_state.dart';
import 'package:edu_diary/features/diary/domain/entity/lesson.dart';
import 'package:edu_diary/features/diary/domain/usecases/load_lessons.dart';
import 'package:edu_diary/features/diary/domain/usecases/load_today_lessons.dart';
import 'package:edu_diary/features/diary/presentation/bloc/diary_event.dart';
import 'package:edu_diary/features/diary/presentation/bloc/diary_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiaryBloc extends Bloc<DiaryEvent, DiaryState> {
  final LoadLessonsUseCase loadLessonsUseCase;
  final LoadTodayLessonsUseCase loadTodayLessonsUseCase;

  final dates = (
    [
      '11.05.2024',
      '22.05.2024',
      '33.05.2024',
      '44.05.2024',
      '55.05.2024',
      '66.05.2024',
      '77.05.2024'
    ],
    [
      '11.05.2024',
      '22.05.2024',
      '33.05.2024',
      '44.05.2024',
      '55.05.2024',
      '26.01.2024',
      '77.05.2024'
    ],
    [
      '11.05.2024',
      '22.05.2024',
      '33.05.2024',
      '44.05.2024',
      '55.05.2024',
      '66.05.2024',
      '77.05.2024'
    ],
  );

  DiaryBloc(
      {required this.loadLessonsUseCase, required this.loadTodayLessonsUseCase})
      : super(DiaryLoadingState()) {
    on<DiaryInitialEvent>(_onDiaryInitialEvent);
    on<DiarySelectDayEvent>(_onDiarySelectDayEvent);
  }

  void _onDiarySelectDayEvent(
      DiarySelectDayEvent event, Emitter<DiaryState> emit) async {
    final dataState = await loadLessonsUseCase(params: event.date);
    if (dataState is DataSuccess) {
      emit(DiaryLoadedState('title todo', dates, 2, dataState.data!));
    } else {
      emit(DiaryFailedState(dataState.error!));
    }
  }

  void _onDiaryInitialEvent(
      DiaryInitialEvent event, Emitter<DiaryState> emit) async {
    final dataState = await loadTodayLessonsUseCase();
    if (dataState is DataSuccess) {
      emit(DiaryLoadedState('title todo', dates, 2, dataState.data!));
    } else {
      emit(DiaryFailedState(dataState.error!));
    }
  }
}
