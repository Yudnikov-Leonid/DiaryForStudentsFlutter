abstract class PerformanceEvent {
  const PerformanceEvent();
}

class GetLessonsEvent extends PerformanceEvent {
  const GetLessonsEvent();
}

class GetFinalLessonsEvent extends PerformanceEvent {
  const GetFinalLessonsEvent();
}

class ChangeQuarterEvent extends PerformanceEvent {
  final int newQuarter;
  ChangeQuarterEvent(this.newQuarter);
}