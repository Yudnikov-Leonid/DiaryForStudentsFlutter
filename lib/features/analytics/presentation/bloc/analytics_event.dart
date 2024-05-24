abstract class AnalyticsEvent {}

class LoadAnalyticsEvent extends AnalyticsEvent {
  final int quarter;
  final int interval;

  LoadAnalyticsEvent(this.quarter, this.interval);
}