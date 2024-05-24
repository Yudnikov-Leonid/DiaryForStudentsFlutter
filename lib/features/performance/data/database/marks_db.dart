import 'package:edu_diary/features/performance/data/database/database_service.dart';
import 'package:edu_diary/features/performance/data/models/cached_mark.dart';
import 'package:sqflite/sqflite.dart';

class MarksDB {
  static const tableName = 'marks';
  static const dateColumn = 'date';
  static const lessonNameColumn = 'lessonName';
  static const markColumn = 'mark';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
      "id" INTEGER NOT NULL,
      "$dateColumn" STRING NOT NULL,
      "$lessonNameColumn" STRING NOT NULL,
      "$markColumn" INTEGER NOT NULL,
      PRIMARY KEY("id" AUTOINCREMENT)
    )""");
  }

  Future<int> insert({required CachedMark mark}) async {
    final database = await PerformanceDatabase().database;
    final row = {dateColumn: mark.date.toString(), lessonNameColumn: mark.lessonName, markColumn: mark.mark};
    return await database.insert(tableName, row);
  }

  Future<List<CachedMark>> getList() async {
    final database = await PerformanceDatabase().database;
    final list = await database.query(tableName);
    return list.map((map) => CachedMark.fromDatabase(map)).toList();
  }

  Future<void> clear() async {
    PerformanceDatabase().delete();
  }
}
