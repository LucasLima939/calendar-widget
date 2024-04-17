import 'package:flutter/material.dart';

import 'calendar_grid_header.dart';
import 'day_cell.dart';

class CalendarGrid extends StatefulWidget {
  final DateTime focusedDate;
  final DateTime? selectedDate;
  final void Function(DateTime) onSelectDate;
  const CalendarGrid({
    super.key,
    required this.focusedDate,
    required this.onSelectDate,
    this.selectedDate,
  });

  @override
  State<CalendarGrid> createState() => _CalendarGridState();
}

class _CalendarGridState extends State<CalendarGrid> {
  @override
  Widget build(BuildContext context) {
    final int totalMonthDays = _getNumberOfDaysInMonth(widget.focusedDate);

    final List<Widget> calendar = [];

    _buildCalendarDays(totalMonthDays, calendar);

    return Column(
      children: [
        CalendarGridHeader(),
        ...calendar,
      ],
    );
  }

  void _buildCalendarDays(int totalMonthDays, List<Widget> calendar) {
    int day = 0;
    bool isNextMonth = false;
    List<Widget> week = [];

    int firstWeekdayIndex = _getFirstWeekdayIndex();
    int totalCalendarDays = totalMonthDays + firstWeekdayIndex;

    _addPreviousMonthDaysOnWeek(week, firstWeekdayIndex);

    for (int i = 0; i < totalCalendarDays; i++) {
      day = i + 1;
      if (day > totalMonthDays) {
        isNextMonth = true;
        day = day - totalMonthDays;
      }

      if (!isNextMonth) {
        week.add(_buildDayCell(day, !isNextMonth));
      } else if (isNextMonth && week.isNotEmpty) {
        for (int j = week.length; j < 7; j++) {
          week.add(_buildDayCell(day, false));
          day++;
        }
      }

      bool isWeekComplete = week.length == 7;
      if (isWeekComplete) {
        calendar.add(Row(children: List.from(week)));
        week.clear();
      }
    }
  }

  void _addPreviousMonthDaysOnWeek(List<Widget> week, int firstWeekdayIndex) {
    if (firstWeekdayIndex == 7) return;
    int lastMonthDay = DateTime(widget.focusedDate.year, widget.focusedDate.month, 0).day;
    for (int day = lastMonthDay - (firstWeekdayIndex - 1); day <= lastMonthDay; day++) {
      week.add(_buildDayCell(day, false));
    }
  }

  Widget _buildDayCell(int day, [bool isActive = true]) {
    DateTime date = DateTime(widget.focusedDate.year, widget.focusedDate.month, day);

    return DayCell(
      isActive: isActive,
      isSelectedDay: _isSelectedDay(date),
      date: date,
      onSelectDate: widget.onSelectDate,
    );
  }

  int _getNumberOfDaysInMonth(DateTime date) {
    DateTime firstDayOfNextMonth = DateTime(date.year, date.month + 1, 1);
    DateTime lastDayOfMonth = firstDayOfNextMonth.subtract(const Duration(days: 1));
    return lastDayOfMonth.day;
  }

  bool _isSelectedDay(DateTime day) {
    if (widget.selectedDate == null) return false;

    final bool isValidDate = widget.selectedDate!.year == day.year && widget.selectedDate!.month == day.month;

    return widget.selectedDate!.day == day.day && isValidDate;
  }

  int _getFirstWeekdayIndex() => DateTime(widget.focusedDate.year, widget.focusedDate.month, 1).weekday;
}
