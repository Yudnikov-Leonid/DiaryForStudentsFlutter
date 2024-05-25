abstract class DiaryEvent {}

class DiaryLoadEvent extends DiaryEvent {}

class DiarySelectDayEvent extends DiaryEvent {
  final String date;
  DiarySelectDayEvent(this.date); 
}

class DiaryPreviousWeek extends DiaryEvent {}

class DiaryNextWeek extends DiaryEvent {}
