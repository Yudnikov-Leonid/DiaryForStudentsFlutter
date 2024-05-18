import 'package:equatable/equatable.dart';

class MarkEntity extends Equatable {
  final int value;
  final String date;

  const MarkEntity(this.value, this.date);
  
  @override
  List<Object?> get props => [value, date];
}