import 'package:edu_diary/core/resources/data_state.dart';
import 'package:edu_diary/features/diary/domain/usecases/load_lessons.dart';
import 'package:edu_diary/features/diary/domain/usecases/load_today_lessons.dart';
import 'package:edu_diary/features/diary/domain/usecases/next_week.dart';
import 'package:edu_diary/features/diary/domain/usecases/previous_week.dart';
import 'package:edu_diary/features/diary/presentation/bloc/diary_event.dart';
import 'package:edu_diary/features/diary/presentation/bloc/diary_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiaryBloc extends Bloc<DiaryEvent, DiaryState> {
  final LoadLessonsUseCase loadLessonsUseCase;
  final LoadTodayLessonsUseCase loadTodayLessonsUseCase;
  final NextWeekUseCase nextWeekUseCase;
  final PreviousWeekUseCase previousWeekUseCase;

  DiaryBloc(
      {required this.loadLessonsUseCase,
      required this.loadTodayLessonsUseCase,
      required this.nextWeekUseCase,
      required this.previousWeekUseCase})
      : super(DiaryLoadingState()) {
    on<DiaryInitialEvent>(_onDiaryInitialEvent);
    on<DiarySelectDayEvent>(_onDiarySelectDayEvent);
    on<DiaryNextWeek>(_onDiaryNextWeek);
    on<DiaryPreviousWeek>(_onDiaryPreviousWeek);
  }

  void _onDiaryNextWeek(DiaryNextWeek event, Emitter<DiaryState> emit) async {
     final dataState = await nextWeekUseCase();
    if (dataState is DataSuccess) {
      emit(DiaryLoadedState(dataState.data!.title, dataState.data!.dates,
          dataState.data!.selectedDay, dataState.data!.lessons[0].date, dataState.data!));
    } else {
      emit(DiaryFailedState(dataState.error!));
    }
  }

  void _onDiaryPreviousWeek(DiaryPreviousWeek event, Emitter<DiaryState> emit) async {
    final dataState = await previousWeekUseCase();
    if (dataState is DataSuccess) {
      emit(DiaryLoadedState(dataState.data!.title, dataState.data!.dates,
          dataState.data!.selectedDay, dataState.data!.lessons[0].date, dataState.data!));
    } else {
      emit(DiaryFailedState(dataState.error!));
    }
  }

  void _onDiarySelectDayEvent(
      DiarySelectDayEvent event, Emitter<DiaryState> emit) async {
    final dataState = await loadLessonsUseCase(params: event.date);
    if (dataState is DataSuccess) {
      emit(DiaryLoadedState(dataState.data!.title, dataState.data!.dates,
          dataState.data!.selectedDay, dataState.data!.lessons[0].date, dataState.data!));
    } else {
      emit(DiaryFailedState(dataState.error!));
    }
  }

  void _onDiaryInitialEvent(
      DiaryInitialEvent event, Emitter<DiaryState> emit) async {
    final dataState = await loadTodayLessonsUseCase();
    if (dataState is DataSuccess) {
      emit(DiaryLoadedState(dataState.data!.title, dataState.data!.dates,
          dataState.data!.selectedDay, dataState.data!.lessons[0].date, dataState.data!));
    } else {
      emit(DiaryFailedState(dataState.error!));
    }
  }
}
