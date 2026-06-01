import 'package:flutter/material.dart';
import '../data/calendar_event_dao.dart';
import '../models/calendar_event.dart';
import '../widgets/app_scaffold.dart';
import 'class_conflict_checker.dart';
import 'class_schedule_list.dart';
import 'form_event_teacher.dart';
import 'teacher_event_list.dart';

class TeacherHome extends StatelessWidget {
  const TeacherHome({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Área do Professor',
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24.0),
            _MenuCard(
              icon: Icons.add_circle_outline,
              title: 'Cadastrar Evento',
              subtitle: 'Adicione provas, trabalhos e eventos para turmas',
              color: Colors.green.shade400,
              onTap: () async {
                final event = await Navigator.push<CalendarEvent>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FormEventTeacher(),
                  ),
                );
                if (event != null) {
                  await CalendarEventDao.instance.save(event);
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Evento salvo com sucesso.')),
                  );
                }
              },
            ),
            const SizedBox(height: 16.0),
            _MenuCard(
              icon: Icons.list_alt,
              title: 'Gerenciar Eventos',
              subtitle: 'Edite ou exclua eventos já cadastrados',
              color: Colors.blue.shade400,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TeacherEventList(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16.0),
            _MenuCard(
              icon: Icons.schedule,
              title: 'Gerenciar Horarios',
              subtitle: 'Cadastre, edite e exclua horarios de aula',
              color: Colors.purple.shade400,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ClassScheduleList(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16.0),
            _MenuCard(
              icon: Icons.event_busy_outlined,
              title: 'Verificar Conflitos',
              subtitle: 'Veja provas e trabalhos de outros professores',
              color: Colors.orange.shade400,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ClassConflictChecker(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _MenuCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: color, width: 2.0),
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.15),
              blurRadius: 8.0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Icon(icon, color: color, size: 28.0),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 13.0, color: Colors.black54),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: color),
          ],
        ),
      ),
    );
  }
}
