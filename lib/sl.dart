import 'package:edu_diary/features/performance/data/data_sources/performance_data_source.dart';
import 'package:edu_diary/features/performance/data/repository/performance_repository_impl.dart';
import 'package:edu_diary/features/performance/domain/repository/performance_repository.dart';
import 'package:edu_diary/features/performance/domain/usecases/change_quarter.dart';
import 'package:edu_diary/features/performance/domain/usecases/change_sort.dart';
import 'package:edu_diary/features/performance/domain/usecases/get_final_lessons.dart';
import 'package:edu_diary/features/performance/domain/usecases/get_lessons.dart';
import 'package:edu_diary/features/performance/presentation/bloc/performance_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<PerformanceDataSource>(PerformanceDataSource());
  sl.registerSingleton<PerformanceRepository>(PerformanceRepositoryImpl(sl()));
  sl.registerSingleton<GetLessonsUseCase>(GetLessonsUseCase(sl()));
  sl.registerSingleton<ChangeQuarterUseCase>(ChangeQuarterUseCase(sl()));
  sl.registerSingleton<GetFinalLessonsUseCase>(GetFinalLessonsUseCase(sl()));
  sl.registerSingleton<ChangeSortUseCase>(ChangeSortUseCase(sl()));
  sl.registerFactory<PerformanceBloc>(() => PerformanceBloc(
      getLessonsUseCase: sl(),
      getFinalLessonsUseCase: sl(),
      changeQuarterUseCase: sl(),
      changeSortUseCase: sl()));
}
