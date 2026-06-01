import 'package:flutter/material.dart';

import '../data/calendar_event_dao.dart';
import '../models/calendar_event.dart';
import '../widgets/app_scaffold.dart';
import 'event_detail.dart';
import 'form_edit_event_teacher.dart';
import 'form_event_teacher.dart';

class TeacherEventList extends StatefulWidget {
  const TeacherEventList({super.key});

  @override
  State<TeacherEventList> createState() => _TeacherEventListState();
}

class _TeacherEventListState extends State<TeacherEventList> {
  final List<CalendarEvent> _events = [];
  String _searchQuery = '';
  TurmaEnum? _filterCourse;

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    final events = await CalendarEventDao.instance.findTeacherEvents();
    if (!mounted) return;
    setState(() {
      _events
        ..clear()
        ..addAll(events);
    });
  }

  List<CalendarEvent> get _filteredEvents {
    return _events.where((event) {
      final matchSearch =
          event.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              (event.description?.toLowerCase().contains(
                    _searchQuery.toLowerCase(),
                  ) ??
                  false);
      final matchCourse = _filterCourse == null || event.course == _filterCourse;
      return matchSearch && matchCourse;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Gerenciar Eventos',
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Buscar...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: Colors.green.shade400,
                          width: 2.0,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    ),
                    onChanged: (value) => setState(() => _searchQuery = value),
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  flex: 2,
                  child: DropdownButtonFormField<TurmaEnum?>(
                    initialValue: _filterCourse,
                    isExpanded: true,
                    decoration: InputDecoration(
                      hintText: 'Turma',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: Colors.green.shade400,
                          width: 2.0,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 0,
                      ),
                    ),
                    items: [
                      const DropdownMenuItem(value: null, child: Text('Todas')),
                      ...TurmaEnum.values.map(
                        (turma) => DropdownMenuItem(
                          value: turma,
                          child: Text(turma.label),
                        ),
                      ),
                    ],
                    onChanged: (value) => setState(() => _filterCourse = value),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _filteredEvents.isEmpty
                ? const Center(
                    child: Text(
                      'Nenhum evento encontrado.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 4.0,
                    ),
                    itemCount: _filteredEvents.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 8.0),
                    itemBuilder: (context, index) {
                      final event = _filteredEvents[index];
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.green.shade100,
                            child: Icon(
                              Icons.event,
                              color: Colors.green.shade600,
                              size: 20.0,
                            ),
                          ),
                          title: Text(event.title),
                          subtitle: Text(
                            '${event.type.label}\n${event.course?.label ?? 'Sem turma'}',
                          ),
                          isThreeLine: true,
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () async {
                                  final updated = await Navigator.push<CalendarEvent>(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => FormEditEventTeacher(
                                        event: event,
                                      ),
                                    ),
                                  );
                                  if (updated != null) {
                                    await CalendarEventDao.instance.save(updated);
                                    await _loadEvents();
                                  }
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () async {
                                  await CalendarEventDao.instance.delete(event.id);
                                  await _loadEvents();
                                },
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EventDetail(event: event),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newEvent = await Navigator.push<CalendarEvent>(
            context,
            MaterialPageRoute(builder: (_) => const FormEventTeacher()),
          );
          if (newEvent != null) {
            await CalendarEventDao.instance.save(newEvent);
            await _loadEvents();
          }
        },
        backgroundColor: Colors.green.shade400,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
