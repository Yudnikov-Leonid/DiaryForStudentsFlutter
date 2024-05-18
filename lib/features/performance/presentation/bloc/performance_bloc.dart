import 'package:edu_diary/core/resources/data_state.dart';
import 'package:edu_diary/features/performance/domain/usecases/get_lessons.dart';
import 'package:edu_diary/features/performance/presentation/bloc/performance_event.dart';
import 'package:edu_diary/features/performance/presentation/bloc/performance_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PerformanceBloc extends Bloc<PerformanceEvent, PerformanceState> {
  final GetLessonsUseCase _getLessonsUseCase;

  PerformanceBloc(this._getLessonsUseCase) : super(const PerformanceLoading()) {
    on<GetLessonsEvent>(onGetLessons);
  }

  void onGetLessons(GetLessonsEvent event, Emitter<PerformanceState> emit) async {
    final dataState = await _getLessonsUseCase();
    if (dataState is DataSuccess) {
      emit(PerformanceSuccess(dataState.data!));
    } else {
      emit(PerformanceFailed(dataState.error!));
    }
  }
}
