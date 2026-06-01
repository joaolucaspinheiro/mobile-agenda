import 'package:sqflite/sqflite.dart';

import '../models/calendar_event.dart';
import 'app_database.dart';

class CalendarEventDao {
  CalendarEventDao._();

  static final CalendarEventDao instance = CalendarEventDao._();

  Future<List<CalendarEvent>> findAll() async {
    final db = await AppDatabase.instance.database;
    final maps = await db.query('calendar_events', orderBy: 'date ASC');
    return maps.map(_fromMap).toList();
  }

  Future<List<CalendarEvent>> findPersonal() async {
    final db = await AppDatabase.instance.database;
    final maps = await db.query(
      'calendar_events',
      where: 'isPersonal = ?',
      whereArgs: [1],
      orderBy: 'date ASC',
    );
    return maps.map(_fromMap).toList();
  }

  Future<List<CalendarEvent>> findTeacherEvents() async {
    final db = await AppDatabase.instance.database;
    final maps = await db.query(
      'calendar_events',
      where: 'isPersonal = ?',
      whereArgs: [0],
      orderBy: 'date ASC',
    );
    return maps.map(_fromMap).toList();
  }

  Future<void> save(CalendarEvent event) async {
    final db = await AppDatabase.instance.database;
    await db.insert(
      'calendar_events',
      _toMap(event),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> delete(String id) async {
    final db = await AppDatabase.instance.database;
    await db.delete('calendar_events', where: 'id = ?', whereArgs: [id]);
  }

  Map<String, dynamic> _toMap(CalendarEvent event) {
    return {
      'id': event.id,
      'title': event.title,
      'description': event.description,
      'date': event.date.toIso8601String(),
      'type': event.type.value,
      'course': event.course?.value,
      'authorId': event.authorId,
      'authorName': event.authorName,
      'isPersonal': event.isPersonal ? 1 : 0,
      'createdAt': event.createdAt.toIso8601String(),
      'updatedAt': event.updatedAt.toIso8601String(),
    };
  }

  CalendarEvent _fromMap(Map<String, dynamic> map) {
    return CalendarEvent(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String?,
      date: DateTime.parse(map['date'] as String),
      type: CalendarEventType.fromValue(map['type'] as String),
      course: map['course'] == null
          ? null
          : TurmaEnum.fromValue(map['course'] as String),
      authorId: map['authorId'] as String,
      authorName: map['authorName'] as String,
      isPersonal: (map['isPersonal'] as int) == 1,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
    );
  }
}
