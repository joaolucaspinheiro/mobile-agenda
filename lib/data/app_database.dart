import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'database_factory_init.dart';

class AppDatabase {
  AppDatabase._();

  static final AppDatabase instance = AppDatabase._();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    await initDatabaseFactory();
    final dbPath = join(await getDatabasesPath(), 'academus.sqlite');
    _database = await openDatabase(
      dbPath,
      version: 2,
      onCreate: (db, version) async {
        await _createTables(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await _createTables(db);
      },
      onOpen: (db) async {
        await _createTables(db);
      },
    );

    return _database!;
  }

  Future<void> _createTables(Database db) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS calendar_events (
            id TEXT PRIMARY KEY,
            title TEXT NOT NULL,
            description TEXT,
            date TEXT NOT NULL,
            type TEXT NOT NULL,
            course TEXT,
            authorId TEXT NOT NULL,
            authorName TEXT NOT NULL,
            isPersonal INTEGER NOT NULL,
            createdAt TEXT NOT NULL,
            updatedAt TEXT NOT NULL
          )
        ''');

        await db.execute('''
          CREATE TABLE IF NOT EXISTS class_schedules (
            id TEXT PRIMARY KEY,
            dayOfWeek TEXT NOT NULL,
            startTime TEXT NOT NULL,
            endTime TEXT NOT NULL,
            subject TEXT NOT NULL,
            professor TEXT NOT NULL,
            room TEXT NOT NULL,
            createdAt TEXT NOT NULL,
            updatedAt TEXT NOT NULL
          )
        ''');
  }
}
