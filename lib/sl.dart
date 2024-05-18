import 'package:dio/dio.dart';
import 'package:edu_diary/features/performance/data/data_sources/performance_api_service.dart';
import 'package:edu_diary/features/performance/data/repository/performance_repository_impl.dart';
import 'package:edu_diary/features/performance/domain/repository/performance_repository.dart';
import 'package:edu_diary/features/performance/domain/usecases/get_lessons.dart';
import 'package:edu_diary/features/performance/presentation/bloc/performance_bloc.dart';
import 'package:edu_diary/features/performance/presentation/bloc/performance_event.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<Dio>(Dio());

  sl.registerSingleton<PerformanceApiService>(PerformanceApiService(sl()));

  sl.registerSingleton<PerformanceRepository>(PerformanceRepositoryImpl(sl()));

  sl.registerSingleton<GetLessonsUseCase>(GetLessonsUseCase(sl()));

  sl.registerFactory<PerformanceBloc>(() => PerformanceBloc(sl()));
}