import 'package:edu_diary/features/performance/domain/entities/mark.dart';
import 'package:flutter/material.dart';

class MarkModel extends MarkEntity {
  const MarkModel(super.value, super.date, super.color);

  factory MarkModel.fromJson(Map<String, dynamic> json) {
    return MarkModel(json['VALUE'], json['DATE'], Colors.black);
  }
}
