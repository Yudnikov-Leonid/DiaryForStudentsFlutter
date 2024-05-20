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

class ChangeSortSettingsEvent extends PerformanceEvent {
  final int newValue;
  ChangeSortSettingsEvent(this.newValue);
}

class ChangeSortOrderSettingsEvent extends PerformanceEvent {
  final int newValue;
  ChangeSortOrderSettingsEvent(this.newValue);
}
