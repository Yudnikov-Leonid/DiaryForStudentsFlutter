import 'package:edu_diary/features/performance/domain/repository/performance_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final PerformanceRepository _performanceRepository;

  MenuBloc(this._performanceRepository) : super(MenuLoadingState()) {
    on<MenuInitEvent>((event, emit) async {
      final newMarksCount = await _performanceRepository.init();
      emit(MenuLoadedState(isPerformanceLoaded: true, newMarksCount: newMarksCount));
    });
  }
}

abstract class MenuEvent {}

class MenuInitEvent extends MenuEvent {}

abstract class MenuState {}

class MenuLoadingState extends MenuState {}

class MenuLoadedState extends MenuState {
  final bool isPerformanceLoaded;
  final int newMarksCount;

  MenuLoadedState({required this.isPerformanceLoaded, required this.newMarksCount});
}