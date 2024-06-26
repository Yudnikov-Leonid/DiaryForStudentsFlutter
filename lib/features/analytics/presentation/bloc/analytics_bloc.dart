import 'package:edu_diary/core/resources/data_state.dart';
import 'package:edu_diary/features/analytics/domain/usecases/load_analytics.dart';
import 'package:edu_diary/features/analytics/presentation/bloc/analytics_event.dart';
import 'package:edu_diary/features/analytics/presentation/bloc/analytics_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnalyticsBloc extends Bloc<AnalyticsEvent, AnalyticsState> {
  final LoadAnalyticsUseCase loadAnalyticsUseCase;

  AnalyticsBloc({required this.loadAnalyticsUseCase})
      : super(AnalyticsLoadingState()) {
    on<LoadAnalyticsEvent>(_onLoadAnalyticsEvent);
  }

  void _onLoadAnalyticsEvent(
      LoadAnalyticsEvent event, Emitter<AnalyticsState> emit) async {
    emit(AnalyticsLoadingState());
    final dataState =
        await loadAnalyticsUseCase(params: (event.quarter, event.interval));
    if (dataState.$1 is DataSuccess) {
      emit(AnalyticsLoadedState(
          averageProgress: dataState.$1.data!.$1,
          marksCount: dataState.$1.data!.$2,
          marksCountProgress: dataState.$1.data!.$3,
          settings: (dataState.$2, event.interval)));
    } else {
      emit(AnalyticsFailState(dataState.$1.error!));
    }
  }
}
