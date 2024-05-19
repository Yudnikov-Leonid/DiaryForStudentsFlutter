abstract class PerformanceEvent {
  const PerformanceEvent();
}

class GetLessonsEvent extends PerformanceEvent {
  const GetLessonsEvent();
}

class ChangeQuarterEvent extends PerformanceEvent {
  final int newQuarter;
  ChangeQuarterEvent(this.newQuarter);
}