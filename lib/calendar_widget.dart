import 'package:calendar_app/calendar_grid.dart';
import 'package:calendar_app/header_component.dart';
import 'package:flutter/material.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderComponent(
          focusedDay: _focusedDay,
          onUpdateFocusedDay: (value) => setState(() => _focusedDay = value),
        ),
        const SizedBox(height: 28),
        CalendarGrid(
          focusedDate: _focusedDay,
          selectedDate: _selectedDay,
          onSelectDate: (value) => setState(() => _selectedDay = value),
        ),
      ],
    );
  }
}
