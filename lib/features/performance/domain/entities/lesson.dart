import 'package:edu_diary/features/performance/domain/entities/mark.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class LessonEntity extends Equatable {
  final String lessonName;
  final List<MarkEntity> marks;
  final double average;

  const LessonEntity(this.lessonName, this.marks, this.average);
  
  @override
  List<Object?> get props => [lessonName, marks, average];
}