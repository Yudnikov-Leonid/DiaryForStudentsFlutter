import 'package:edu_diary/features/performance/domain/repository/performance_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final PerformanceRepository _performanceRepository;

  MenuBloc(this._performanceRepository) : super(MenuLoadingState()) {
    on<MenuInitEvent>((event, emit) async {
      await _performanceRepository.getLessons();
      emit(MenuLoadedState(isPerformanceLoaded: true));
    });
  }
}

abstract class MenuEvent {}

class MenuInitEvent extends MenuEvent {}

abstract class MenuState {}

class MenuLoadingState extends MenuState {}

class MenuLoadedState extends MenuState {
  final bool isPerformanceLoaded;

  MenuLoadedState({required this.isPerformanceLoaded});
}