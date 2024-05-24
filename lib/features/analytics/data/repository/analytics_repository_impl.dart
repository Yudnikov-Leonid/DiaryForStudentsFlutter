import 'package:edu_diary/core/resources/data_state.dart';
import 'package:edu_diary/features/analytics/domain/entity/average_progress.dart';
import 'package:edu_diary/features/analytics/domain/repository/analytics_repository.dart';
import 'package:edu_diary/features/performance/domain/entities/mark.dart';
import 'package:edu_diary/features/performance/domain/repository/performance_repository.dart';
import 'package:intl/intl.dart';

class AnalyticsRepositoryImpl implements AnalyticsRepository {
  final PerformanceRepository _performanceRepository;
  AnalyticsRepositoryImpl(this._performanceRepository);

  @override
  Future<DataState<AverageProgress>> averageProgress(int interval) async {
    final lessonsDataState = await _performanceRepository.getLessons();
    if (lessonsDataState is DataFailed) {
      return DataFailed(lessonsDataState.error!);
    }

    List<MarkEntity> marks = [];
    lessonsDataState.data!.$1.forEach((e) {
      marks.addAll(e.marks);
    });

    final List<double> result = [];
    final List<String> labels = [];
    final period = _performanceRepository.periods()[3];

    //calculate weeks count
    var firstDate =
        DateFormat('dd.MM.yy').parse(period.$1).millisecondsSinceEpoch ~/
            86400000;
    var lastDate =
        DateFormat('dd.MM.yy').parse(period.$2).millisecondsSinceEpoch ~/
            86400000;

    final weeksCount = (lastDate - firstDate) / interval;

    final String labelText;
    if (interval > 0 && interval < 7) {
      labelText = 'day';
    } else if (interval == 7) {
      labelText = 'week';
    } else {
      labelText = 'month';
    }

    for (int i = 0; i < weeksCount; i++) {
      if (marks.isNotEmpty) {
        result.insert(
            0,
            (marks.fold<int>(0, (a, b) => a + b.value) / marks.length * 100)
                    .round() /
                100);
        labels.add('$i $labelText');
      }
      marks = marks.where((mark) {
        final parsed = DateFormat('dd.MM.yy')
            .parse("${mark.date}.${period.$2.substring(6)}");
        return parsed.millisecondsSinceEpoch ~/ 86400000 < lastDate;
      }).toList();
      lastDate -= interval;
    }

    return DataSuccess(AverageProgress(result, labels));
  }
}
