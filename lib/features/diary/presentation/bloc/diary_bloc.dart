import 'package:edu_diary/core/resources/data_state.dart';
import 'package:edu_diary/features/diary/domain/entity/lesson.dart';
import 'package:edu_diary/features/diary/domain/usecases/load_lessons.dart';
import 'package:edu_diary/features/diary/presentation/bloc/diary_event.dart';
import 'package:edu_diary/features/diary/presentation/bloc/diary_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiaryBloc extends Bloc<DiaryEvent, DiaryState> {
  final LoadLessonsUseCase loadLessonsUseCase;

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
        '66.05.2024',
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

  DiaryBloc({required this.loadLessonsUseCase}) : super(DiaryLoadingState()) {
    on<DiaryInitialEvent>(_onDiaryInitialEvent);
  }

  void _onDiaryInitialEvent(DiaryInitialEvent event, Emitter<DiaryState> emit) async {
    final dataState = await loadLessonsUseCase(params: '24.01.2024');
    if (dataState is DataSuccess) {
      emit(DiaryLoadedState('title todo', dates, 2, dataState.data!));
    } else {
      emit(DiaryFailedState(dataState.error!));
    }
  
  }
}
