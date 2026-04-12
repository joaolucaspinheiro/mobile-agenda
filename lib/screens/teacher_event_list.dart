import 'package:flutter/material.dart';
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
  final List<CalendarEvent> _events = [
    CalendarEvent(
      id: 't1',
      title: 'Prova de Algoritmos',
      description: 'Capítulos 3 e 4',
      date: DateTime.now().add(const Duration(days: 5)),
      type: CalendarEventType.prova,
      course: TurmaEnum.ads3,
      authorId: 'teacher_user',
      authorName: 'Professor',
      isPersonal: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    CalendarEvent(
      id: 't2',
      title: 'Entrega do Projeto Mobile',
      description: 'Enviar pelo AVA',
      date: DateTime.now().add(const Duration(days: 10)),
      type: CalendarEventType.trabalho,
      course: TurmaEnum.ads3,
      authorId: 'teacher_user',
      authorName: 'Professor',
      isPersonal: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];
  String _searchQuery = '';
  TurmaEnum? _filterCourse;

  List<CalendarEvent> get _filteredEvents {
    return _events.where((e) {
      final matchSearch =
          e.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (e.description?.toLowerCase().contains(_searchQuery.toLowerCase()) ??
              false);
      final matchCourse = _filterCourse == null || e.course == _filterCourse;
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
                    onChanged: (val) => setState(() => _searchQuery = val),
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
                        (t) => DropdownMenuItem(value: t, child: Text(t.label)),
                      ),
                    ],
                    onChanged: (val) => setState(() => _filterCourse = val),
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
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(color: Colors.grey.shade200),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 4.0,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 4.0,
                          ),
                          leading: CircleAvatar(
                            backgroundColor: Colors.green.shade100,
                            child: Icon(
                              Icons.event,
                              color: Colors.green.shade600,
                              size: 20.0,
                            ),
                          ),
                          title: Text(
                            event.title,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                event.type.label,
                                style: TextStyle(
                                  color: Colors.green.shade600,
                                  fontSize: 12.0,
                                ),
                              ),
                              if (event.course != null)
                                Text(
                                  event.course!.label,
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.black54,
                                  ),
                                ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${event.date.day.toString().padLeft(2, '0')}/${event.date.month.toString().padLeft(2, '0')}',
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.black45,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                  size: 20.0,
                                ),
                                onPressed: () async {
                                  final updated =
                                      await Navigator.push<CalendarEvent>(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => FormEditEventTeacher(
                                            event: event,
                                          ),
                                        ),
                                      );
                                  if (updated != null) {
                                    setState(() {
                                      final i = _events.indexWhere(
                                        (e) => e.id == updated.id,
                                      );
                                      if (i != -1) _events[i] = updated;
                                    });
                                  }
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 20.0,
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: const Text('Excluir evento'),
                                      content: Text(
                                        'Deseja excluir "${event.title}"?',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text('Cancelar'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            setState(
                                              () => _events.removeWhere(
                                                (e) => e.id == event.id,
                                              ),
                                            );
                                            Navigator.pop(context);
                                          },
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.red,
                                          ),
                                          child: const Text('Excluir'),
                                        ),
                                      ],
                                    ),
                                  );
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
          if (newEvent != null) setState(() => _events.add(newEvent));
        },
        backgroundColor: Colors.green.shade400,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
