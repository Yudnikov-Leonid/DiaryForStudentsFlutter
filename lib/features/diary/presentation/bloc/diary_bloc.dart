import 'package:edu_diary/features/diary/domain/entity/lesson.dart';
import 'package:edu_diary/features/diary/presentation/bloc/diary_event.dart';
import 'package:edu_diary/features/diary/presentation/bloc/diary_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiaryBloc extends Bloc<DiaryEvent, DiaryState> {
  DiaryBloc() : super(DiaryLoadingState()) {
    on<DiaryInitialEvent>(_onDiaryInitialEvent);
  }

  void _onDiaryInitialEvent(DiaryInitialEvent event, Emitter<DiaryState> emit) {
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
    final lessons = [
      DiaryLesson('Name 1', 1, 'Topic 1', 'Homework 1'),
      DiaryLesson('Name 2', 2, 'Topic 2', 'Homework 2')
    ];
    emit(DiaryLoadedState('title todo', dates, 2, lessons));
  }
}
