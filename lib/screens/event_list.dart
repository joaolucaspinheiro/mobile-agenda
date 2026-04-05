import 'package:flutter/material.dart';
import '../models/calendar_event.dart';
import '../widgets/app_scaffold.dart';
import 'event_detail.dart';

class EventList extends StatefulWidget {
  const EventList({super.key, required this.events});

  final List<CalendarEvent> events;

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  String _search = '';
  DateTime? _initFilterDate;
  DateTime? _endFilterDate;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    @override
    void dispose() {
      _searchController.dispose();
      super.dispose();
    }

    final filteredEvents = widget.events.where((event) {
      final matchesSearch = event.title.toLowerCase().contains(
        _search.toLowerCase(),
      );
      final matchesStart =
          _initFilterDate == null || !event.date.isBefore(_initFilterDate!);
      final matchesEnd =
          _endFilterDate == null || !event.date.isAfter(_endFilterDate!);
      return matchesSearch && matchesStart && matchesEnd;
    }).toList();
    return AppScaffold(
      title: 'Eventos',
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Pesquisar...',
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.green.shade400,
                        size: 18.0,
                      ),
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
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 8.0,
                      ),
                    ),
                    onChanged: (value) => setState(() => _search = value),
                  ),
                ),
                const SizedBox(width: 4.0),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _initFilterDate ?? DateTime.now(),
                        firstDate: DateTime.now().subtract(Duration(days: 365)),
                        lastDate: DateTime.now().add(Duration(days: 365)),
                      );
                      if (picked != null)
                        setState(() => _initFilterDate = picked);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Text(
                        _initFilterDate == null
                            ? 'Início'
                            : '${_initFilterDate!.day}/${_initFilterDate!.month}',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: _initFilterDate == null
                              ? Colors.grey
                              : Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 4.0),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _endFilterDate ?? DateTime.now(),
                        firstDate: DateTime.now().subtract(Duration(days: 365)),
                        lastDate: DateTime.now().add(Duration(days: 365)),
                      );
                      if (picked != null)
                        setState(() => _endFilterDate = picked);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Text(
                        _endFilterDate == null
                            ? 'Fim'
                            : '${_endFilterDate!.day}/${_endFilterDate!.month}',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: _endFilterDate == null
                              ? Colors.grey
                              : Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: Icon(Icons.clear, color: Colors.red, size: 18.0),
                  onPressed: () => setState(() {
                    _initFilterDate = null;
                    _endFilterDate = null;
                    _search = '';
                    _searchController.clear();
                  }),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredEvents.length,
              itemBuilder: (context, index) {
                final event = filteredEvents[index];
                return ListTile(
                  leading: Icon(Icons.event, color: Colors.green.shade400),
                  title: Text(event.title),
                  trailing: Text(
                    '${event.date.day.toString().padLeft(2, '0')}/${event.date.month.toString().padLeft(2, '0')}/${event.date.year}',
                    style: const TextStyle(fontSize: 12, color: Colors.black),
                  ),
                  subtitle: Text(event.type.label),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventDetail(event: event),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
