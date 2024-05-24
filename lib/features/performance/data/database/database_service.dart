import 'package:edu_diary/features/performance/data/database/marks_db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class PerformanceDatabase {
  Database? _database;

  Future<Database> get database async {
    _database ??= await _initialize();
    return _database!;
  }

  Future<String> get fullPath async {
    const name = 'marks.db';
    final path = await getDatabasesPath();
    return join(path, name);
  }

  Future<Database> _initialize() async {
    final path = await fullPath;
    final database = await openDatabase(path,
        version: 1, onCreate: create, singleInstance: true);
    return database;
  }

  Future<void> create(Database database, int version) async =>
      await MarksDB().createTable(database);

  Future<void> delete() async {
    databaseFactory.deleteDatabase(await fullPath);
  }
}
