import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../database/database.dart';
import '../../theme/app_theme.dart';

class CalendarView extends StatefulWidget {
  final AppDatabase database;

  const CalendarView({super.key, required this.database});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.blancCasse,
      appBar: AppBar(
        title: const Text('Calendrier'),
      ),
      body: Column(
        children: [
          TableCalendar<CalendarEvent>(
            firstDay: DateTime.now().subtract(const Duration(days: 365)),
            lastDay: DateTime.now().add(const Duration(days: 365)),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
              _showDayEvents(selectedDay);
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: AppTheme.terracotta,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: AppTheme.terracotta.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
            ),
          ),
          const Divider(),
          Expanded(
            child: _selectedDay == null
                ? const Center(
                    child: Text('Sélectionnez une date'),
                  )
                : _buildEventsList(_selectedDay!),
          ),
        ],
      ),
    );
  }

  Widget _buildEventsList(DateTime date) {
    return StreamBuilder<List<CalendarEvent>>(
      stream: _getEventsForDay(date),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Erreur: ${snapshot.error}'));
        }

        final events = snapshot.data ?? [];
        if (events.isEmpty) {
          return const Center(child: Text('Aucun événement ce jour'));
        }

        return ListView.builder(
          itemCount: events.length,
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, index) {
            final event = events[index];
            return _buildEventCard(event);
          },
        );
      },
    );
  }

  Widget _buildEventCard(CalendarEvent event) {
    return Card(
      child: ListTile(
        leading: Icon(
          event.getIcon(),
          color: AppTheme.terracotta,
        ),
        title: Text(event.title),
        subtitle: Text(event.description),
      ),
    );
  }

  void _showDayEvents(DateTime day) {
    // TODO: Implémenter l'affichage des événements
  }

  Stream<List<CalendarEvent>> _getEventsForDay(DateTime date) {
    // TODO: Implémenter la récupération des événements
    return Stream.value([]);
  }
}

class CalendarEvent {
  final String title;
  final String description;
  final EventType type;

  CalendarEvent({
    required this.title,
    required this.description,
    required this.type,
  });

  IconData getIcon() {
    switch (type) {
      case EventType.rendezvous:
        return Icons.event;
      case EventType.retour:
        return Icons.assignment_return;
      case EventType.depart:
        return Icons.assignment_turned_in;
      case EventType.paiement:
        return Icons.payment;
    }
  }
}

enum EventType {
  rendezvous,
  retour,
  depart,
  paiement,
}
