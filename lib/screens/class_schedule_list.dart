import 'package:flutter/material.dart';

import '../data/class_schedule_dao.dart';
import '../models/class_schedule.dart';
import '../widgets/app_scaffold.dart';

class ClassScheduleList extends StatefulWidget {
  const ClassScheduleList({super.key});

  @override
  State<ClassScheduleList> createState() => _ClassScheduleListState();
}

class _ClassScheduleListState extends State<ClassScheduleList> {
  final List<ClassSchedule> _schedules = [];

  @override
  void initState() {
    super.initState();
    _loadSchedules();
  }

  Future<void> _loadSchedules() async {
    final schedules = await ClassScheduleDao.instance.findAll();
    if (!mounted) return;
    setState(() {
      _schedules
        ..clear()
        ..addAll(schedules);
    });
  }

  Future<ClassSchedule?> _openForm({ClassSchedule? schedule}) async {
    final subjectController = TextEditingController(
      text: schedule?.subject ?? '',
    );
    final professorController = TextEditingController(
      text: schedule?.professor ?? '',
    );
    final roomController = TextEditingController(text: schedule?.room ?? '');
    final startController = TextEditingController(
      text: schedule?.startTime ?? '',
    );
    final endController = TextEditingController(text: schedule?.endTime ?? '');
    AppDay selectedDay = schedule?.dayOfWeek ?? AppDay.segunda;

    final result = await showDialog<ClassSchedule>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(schedule == null ? 'Novo horario' : 'Editar horario'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonFormField<AppDay>(
                      initialValue: selectedDay,
                      decoration: const InputDecoration(labelText: 'Dia'),
                      items: AppDay.values.map((day) {
                        return DropdownMenuItem(
                          value: day,
                          child: Text(day.label),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setDialogState(() => selectedDay = value);
                        }
                      },
                    ),
                    TextField(
                      controller: subjectController,
                      decoration: const InputDecoration(labelText: 'Materia'),
                    ),
                    TextField(
                      controller: professorController,
                      decoration: const InputDecoration(labelText: 'Professor'),
                    ),
                    TextField(
                      controller: roomController,
                      decoration: const InputDecoration(labelText: 'Sala'),
                    ),
                    TextField(
                      controller: startController,
                      decoration: const InputDecoration(
                        labelText: 'Inicio',
                        hintText: 'Ex: 19:00',
                      ),
                    ),
                    TextField(
                      controller: endController,
                      decoration: const InputDecoration(
                        labelText: 'Fim',
                        hintText: 'Ex: 20:40',
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                ),
                FilledButton(
                  onPressed: () {
                    if (subjectController.text.trim().isEmpty ||
                        professorController.text.trim().isEmpty ||
                        roomController.text.trim().isEmpty ||
                        startController.text.trim().isEmpty ||
                        endController.text.trim().isEmpty) {
                      return;
                    }

                    final now = DateTime.now();
                    Navigator.pop(
                      context,
                      ClassSchedule(
                        id: schedule?.id ??
                            now.microsecondsSinceEpoch.toString(),
                        dayOfWeek: selectedDay,
                        startTime: startController.text.trim(),
                        endTime: endController.text.trim(),
                        subject: subjectController.text.trim(),
                        professor: professorController.text.trim(),
                        room: roomController.text.trim(),
                        createdAt: schedule?.createdAt ?? now,
                        updatedAt: now,
                      ),
                    );
                  },
                  child: const Text('Salvar'),
                ),
              ],
            );
          },
        );
      },
    );

    subjectController.dispose();
    professorController.dispose();
    roomController.dispose();
    startController.dispose();
    endController.dispose();
    return result;
  }

  Future<void> _save(ClassSchedule schedule) async {
    await ClassScheduleDao.instance.save(schedule);
    await _loadSchedules();
  }

  Future<void> _delete(ClassSchedule schedule) async {
    await ClassScheduleDao.instance.delete(schedule.id);
    await _loadSchedules();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Horarios',
      body: _schedules.isEmpty
          ? const Center(child: Text('Nenhum horario cadastrado.'))
          : ListView.separated(
              padding: const EdgeInsets.all(12.0),
              itemCount: _schedules.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8.0),
              itemBuilder: (context, index) {
                final schedule = _schedules[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.green.shade100,
                      child: Icon(
                        Icons.schedule,
                        color: Colors.green.shade700,
                      ),
                    ),
                    title: Text(schedule.subject),
                    subtitle: Text(
                      '${schedule.dayOfWeek.label} - ${schedule.startTime} as ${schedule.endTime}\n'
                      'Professor: ${schedule.professor} | Sala: ${schedule.room}',
                    ),
                    isThreeLine: true,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () async {
                            final updated = await _openForm(schedule: schedule);
                            if (updated != null) {
                              await _save(updated);
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            await _delete(schedule);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green.shade400,
        foregroundColor: Colors.white,
        onPressed: () async {
          final schedule = await _openForm();
          if (schedule != null) {
            await _save(schedule);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
