import 'package:edu_diary/features/performance/domain/entities/mark.dart';

class MarkModel extends MarkEntity {
  const MarkModel(super.value, super.date);

  factory MarkModel.fromJson(Map<String, dynamic> json) {
    return MarkModel(json['VALUE'], json['DATE']);
  }
}