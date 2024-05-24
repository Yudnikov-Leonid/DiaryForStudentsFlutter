import 'package:edu_diary/features/performance/data/models/cached_mark.dart';
import 'package:edu_diary/features/performance/domain/entities/mark.dart';

class MarkModel extends MarkEntity {
  const MarkModel(super.value, super.date, super.isChecked);

//TODO dry
  factory MarkModel.fromJson(Map<String, dynamic> json, String lessonName,
      List<CachedMark> cachedMarks) {
    var isChecked = false;
    if (cachedMarks.isNotEmpty) {
      for (int i = 0; i < cachedMarks.length; i++) {
        final date = cachedMarks[i].date.length == 4
            ? '0${cachedMarks[i].date}'
            : cachedMarks[i].date;
        if (date == json['DATE'].substring(0, 5) &&
            cachedMarks[i].mark == json['VALUE'] &&
            cachedMarks[i].lessonName == lessonName) {
          print('isChecked = true');
          isChecked = true;
          break;
        }
      }
    } else {
      isChecked = true;
    }
    return MarkModel(json['VALUE'], json['DATE'], isChecked);
  }

  factory MarkModel.fromJsonShortDate(Map<String, dynamic> json,
      String lessonName, List<CachedMark> cachedMarks) {
    var isChecked = false;
    if (cachedMarks.isNotEmpty) {
      for (int i = 0; i < cachedMarks.length; i++) {
        final date = cachedMarks[i].date.length == 4
            ? '0${cachedMarks[i].date}'
            : cachedMarks[i].date;
        if (date == json['DATE'].substring(0, 5) &&
            cachedMarks[i].mark == json['VALUE'] &&
            cachedMarks[i].lessonName == lessonName) {
          print('isChecked = true');
          isChecked = true;
          break;
        }
      }
    } else {
      isChecked = true;
    }
    return MarkModel(json['VALUE'], json['DATE'].substring(0, 5), isChecked);
  }
}
