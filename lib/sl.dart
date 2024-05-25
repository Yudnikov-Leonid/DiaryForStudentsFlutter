import 'package:edu_diary/core/presentation/validation.dart';
import 'package:edu_diary/core/service/edu_user.dart';
import 'package:edu_diary/features/analytics/data/repository/analytics_repository_impl.dart';
import 'package:edu_diary/features/analytics/domain/repository/analytics_repository.dart';
import 'package:edu_diary/features/analytics/domain/usecases/load_analytics.dart';
import 'package:edu_diary/features/analytics/presentation/bloc/analytics_bloc.dart';
import 'package:edu_diary/features/diary/data/data_sources/diary_data_source.dart';
import 'package:edu_diary/features/diary/data/repository/diary_repository_impl.dart';
import 'package:edu_diary/features/diary/domain/repository/diary_repository.dart';
import 'package:edu_diary/features/diary/domain/usecases/load_lessons.dart';
import 'package:edu_diary/features/diary/domain/usecases/load_today_lessons.dart';
import 'package:edu_diary/features/diary/domain/usecases/next_week.dart';
import 'package:edu_diary/features/diary/domain/usecases/previous_week.dart';
import 'package:edu_diary/features/diary/presentation/bloc/diary_bloc.dart';
import 'package:edu_diary/features/diary/presentation/bloc/diary_event.dart';
import 'package:edu_diary/features/login/data/data_sources/login_data_source.dart';
import 'package:edu_diary/features/login/data/repository/login_repository_impl.dart';
import 'package:edu_diary/features/login/domain/repository/login_repository.dart';
import 'package:edu_diary/features/login/domain/usecases/login.dart';
import 'package:edu_diary/features/login/presentation/bloc/login_bloc.dart';
import 'package:edu_diary/features/menu/presentation/bloc/menu_bloc.dart';
import 'package:edu_diary/features/performance/data/data_sources/performance_cloud_data_source.dart';
import 'package:edu_diary/features/performance/data/database/marks_db.dart';
import 'package:edu_diary/features/performance/data/repository/performance_repository_impl.dart';
import 'package:edu_diary/features/performance/domain/repository/performance_repository.dart';
import 'package:edu_diary/features/performance/domain/usecases/change_quarter.dart';
import 'package:edu_diary/features/performance/domain/usecases/change_sort.dart';
import 'package:edu_diary/features/performance/domain/usecases/change_sort_order.dart';
import 'package:edu_diary/features/performance/domain/usecases/get_final_lessons.dart';
import 'package:edu_diary/features/performance/domain/usecases/get_lessons.dart';
import 'package:edu_diary/features/performance/presentation/bloc/performance_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<EduUser>(EduUser(await SharedPreferences.getInstance()));

  sl.registerSingleton<PerformanceCloudDataSource>(
      PerformanceCloudDataSource());
  sl.registerSingleton<MarksDB>(MarksDB());
  sl.registerSingleton<PerformanceRepository>(
      PerformanceRepositoryImpl(sl(), sl()));
  sl.registerSingleton<GetLessonsUseCase>(GetLessonsUseCase(sl()));
  sl.registerSingleton<ChangeQuarterUseCase>(ChangeQuarterUseCase(sl()));
  sl.registerSingleton<GetFinalLessonsUseCase>(GetFinalLessonsUseCase(sl()));
  sl.registerSingleton<ChangeSortUseCase>(ChangeSortUseCase(sl()));
  sl.registerSingleton<ChangeSortOrderUseCase>(ChangeSortOrderUseCase(sl()));
  sl.registerFactory<PerformanceBloc>(() => PerformanceBloc(
      getLessonsUseCase: sl(),
      getFinalLessonsUseCase: sl(),
      changeQuarterUseCase: sl(),
      changeSortUseCase: sl(),
      changeSortOrderUseCase: sl()));

  sl.registerFactory<MenuBloc>(() => MenuBloc(sl()));

  sl.registerSingleton<LoginDataSource>(LoginDataSource());
  sl.registerSingleton<LoginRepository>(LoginRepositoryImpl(sl(), sl()));
  sl.registerSingleton<LoginUseCase>(LoginUseCase(sl(),
      loginUiValidator: LoginUiValidator(minLength: 3),
      passwordUiValidator: PasswordUiValidator(minLength: 3)));
  sl.registerFactory<LoginBloc>(() => LoginBloc(loginUseCase: sl()));

  sl.registerSingleton<AnalyticsRepository>(AnalyticsRepositoryImpl(sl()));
  sl.registerSingleton<LoadAnalyticsUseCase>(LoadAnalyticsUseCase(sl()));
  sl.registerFactory<AnalyticsBloc>(
      () => AnalyticsBloc(loadAnalyticsUseCase: sl()));

  sl.registerSingleton<DiaryDataSource>(DiaryDataSource());
  sl.registerSingleton<DiaryRepository>(DiaryRepositoryImpl(sl()));
  sl.registerSingleton<LoadLessonsUseCase>(LoadLessonsUseCase(sl()));
  sl.registerSingleton<LoadTodayLessonsUseCase>(LoadTodayLessonsUseCase(sl()));
  sl.registerSingleton<NextWeekUseCase>(NextWeekUseCase(sl()));
  sl.registerSingleton<PreviousWeekUseCase>(PreviousWeekUseCase(sl()));
  sl.registerFactory<DiaryBloc>(() => DiaryBloc(
      loadLessonsUseCase: sl(),
      loadTodayLessonsUseCase: sl(),
      nextWeekUseCase: sl(),
      previousWeekUseCase: sl()));
}
