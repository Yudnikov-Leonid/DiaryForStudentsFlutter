import 'package:edu_diary/core/resources/data_state.dart';
import 'package:edu_diary/features/analytics/domain/entity/average_progress.dart';
import 'package:edu_diary/features/analytics/domain/entity/marks_count.dart';
import 'package:edu_diary/features/analytics/domain/entity/marks_count_progress.dart';
import 'package:edu_diary/features/analytics/domain/repository/analytics_repository.dart';
import 'package:edu_diary/features/performance/domain/entities/mark.dart';
import 'package:edu_diary/features/performance/domain/repository/performance_repository.dart';
import 'package:intl/intl.dart';

class AnalyticsRepositoryImpl implements AnalyticsRepository {
  final PerformanceRepository _performanceRepository;
  AnalyticsRepositoryImpl(this._performanceRepository);

  @override
  Future<DataState<(AverageProgress, MarksCount, MarksCountProgress)>>
      analytics(int quarter, int interval) async {
    final lessonsDataState =
        await _performanceRepository.getLessonsByQuarter(quarter);
    if (lessonsDataState is DataFailed) {
      return DataFailed(lessonsDataState.error!);
    }

    List<MarkEntity> marks = [];
    lessonsDataState.data!.forEach((e) {
      marks.addAll(e.marks);
    });

    final fiveCount = marks.where((mark) => mark.value == 5).length;
    final fourCount = marks.where((mark) => mark.value == 4).length;
    final threeCount = marks.where((mark) => mark.value == 3).length;
    final twoCount = marks.where((mark) => mark.value == 2).length;
    final oneCount = marks.where((mark) => mark.value == 1).length;
    final marksCount =
        MarksCount([oneCount, twoCount, threeCount, fourCount, fiveCount]);

    final List<double> result = [];
    final List<List<int>> countProgressResult = [];
    final List<String> labels = [];
    final period = _performanceRepository.periods()[quarter - 1];

    //calculate weeks count
    var firstDate =
        DateFormat('dd.MM.yy').parse(period.$1).millisecondsSinceEpoch ~/
            86400000;
    var lastDate =
        DateFormat('dd.MM.yy').parse(period.$2).millisecondsSinceEpoch ~/
            86400000;

    final weeksCount = (lastDate - firstDate) ~/ interval + 1;

    final String labelText;
    if (interval > 0 && interval < 7) {
      labelText = 'day';
    } else if (interval == 7) {
      labelText = 'week';
    } else {
      labelText = 'month';
    }

    for (int i = 1; i < weeksCount; i++) {
      if ((quarter == 5 && marks.length < 15) || marks.length < 5) {
        break;
      }
      if (marks.isNotEmpty) {
        result.insert(
            0,
            (marks.fold<int>(0, (a, b) => a + b.value) / marks.length * 100)
                    .round() /
                100);
        final fiveCount = marks.where((mark) => mark.value == 5).length;
        final fourCount = marks.where((mark) => mark.value == 4).length;
        final threeCount = marks.where((mark) => mark.value == 3).length;
        final twoCount = marks.where((mark) => mark.value == 2).length;
        final oneCount = marks.where((mark) => mark.value == 1).length;
        countProgressResult
            .insert(0, [oneCount, twoCount, threeCount, fourCount, fiveCount]);
        labels.add('$i $labelText');
      }
      marks = marks.where((mark) {
        final parsed = DateFormat('dd.MM.yy')
            .parse(mark.date);
        return parsed.millisecondsSinceEpoch ~/ 86400000 < lastDate;
      }).toList();
      lastDate -= interval;
    }

    return DataSuccess((
      AverageProgress(result, labels),
      marksCount,
      MarksCountProgress(countProgressResult, labels)
    ));
  }

  @override
  int currentQuarter() {
    return _performanceRepository.currentQuarter();
  }
}
