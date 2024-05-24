import 'package:equatable/equatable.dart';

class MarkEntity extends Equatable {
  final int value;
  final String date;
  final bool isChecked;

  const MarkEntity(this.value, this.date, this.isChecked);

  @override
  List<Object?> get props => [value, date, isChecked];
}
