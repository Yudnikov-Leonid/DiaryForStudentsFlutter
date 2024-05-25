abstract class DiaryEvent {}

class DiaryInitialEvent extends DiaryEvent {}

class DiarySelectDayEvent extends DiaryEvent {
  final String date;
  DiarySelectDayEvent(this.date); 
}

class DiaryPreviousWeek extends DiaryEvent {}

class DiaryNextWeek extends DiaryEvent {}
