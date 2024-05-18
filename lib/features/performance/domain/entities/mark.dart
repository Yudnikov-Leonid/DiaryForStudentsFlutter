import 'dart:ui';

import 'package:equatable/equatable.dart';

class MarkEntity extends Equatable {
  final int value;
  final String date;
  final Color color;

  const MarkEntity(this.value, this.date, this.color);
  
  @override
  List<Object?> get props => [value, date];
}