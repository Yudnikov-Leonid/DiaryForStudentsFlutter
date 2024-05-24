import 'package:edu_diary/features/performance/data/database/marks_db.dart';

class CachedMark {
  final int? id;
  final String date;
  final String lessonName;
  final int mark;

  CachedMark(this.id, this.date, this.lessonName, this.mark);

  factory CachedMark.fromDatabase(Map<String, dynamic> map) {
    return CachedMark(map['id'], map[MarksDB.dateColumn].toString(),
        map[MarksDB.lessonNameColumn], map[MarksDB.markColumn]);
  }
}
