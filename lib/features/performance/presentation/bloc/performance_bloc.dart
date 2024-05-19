import 'package:edu_diary/core/resources/data_state.dart';
import 'package:edu_diary/features/performance/domain/usecases/change_quarter.dart';
import 'package:edu_diary/features/performance/domain/usecases/get_lessons.dart';
import 'package:edu_diary/features/performance/presentation/bloc/performance_event.dart';
import 'package:edu_diary/features/performance/presentation/bloc/performance_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PerformanceBloc extends Bloc<PerformanceEvent, PerformanceState> {
  final GetLessonsUseCase getLessonsUseCase;
  final ChangeQuarterUseCase changeQuarterUseCase;

  PerformanceBloc({required this.getLessonsUseCase, required this.changeQuarterUseCase}) : super(const PerformanceLoading()) {
    on<GetLessonsEvent>(onGetLessons);
    on<ChangeQuarterEvent>(onChangeQuarter);
  }

  void onChangeQuarter(ChangeQuarterEvent event, Emitter<PerformanceState> emit) async {
    emit(const PerformanceLoading());
    final dataState = await changeQuarterUseCase(params: event.newQuarter);
    if (dataState is DataSuccess) {
      emit(PerformanceSuccess(dataState.data!, event.newQuarter));
    } else {
      emit(PerformanceFailed(dataState.error!));
    }
  }

  void onGetLessons(GetLessonsEvent event, Emitter<PerformanceState> emit) async {
    final dataState = await getLessonsUseCase();
    if (dataState is DataSuccess) {
      emit(PerformanceSuccess(dataState.data!.$1, dataState.data!.$2));
    } else {
      emit(PerformanceFailed(dataState.error!));
    }
  }
}
