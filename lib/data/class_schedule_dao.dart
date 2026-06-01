import 'package:sqflite/sqflite.dart';

import '../models/class_schedule.dart';
import 'app_database.dart';

class ClassScheduleDao {
  ClassScheduleDao._();

  static final ClassScheduleDao instance = ClassScheduleDao._();

  Future<List<ClassSchedule>> findAll() async {
    final db = await AppDatabase.instance.database;
    final maps = await db.query('class_schedules', orderBy: 'dayOfWeek ASC');
    return maps.map(ClassSchedule.fromJson).toList();
  }

  Future<void> save(ClassSchedule schedule) async {
    final db = await AppDatabase.instance.database;
    await db.insert(
      'class_schedules',
      schedule.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> delete(String id) async {
    final db = await AppDatabase.instance.database;
    await db.delete('class_schedules', where: 'id = ?', whereArgs: [id]);
  }
}
