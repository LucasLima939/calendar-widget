import 'package:flutter/material.dart';

class DayCell extends StatelessWidget {
  final bool isActive;
  final bool isSelectedDay;
  final DateTime date;
  final void Function(DateTime) onSelectDate;
  const DayCell({
    super.key,
    required this.isActive,
    required this.isSelectedDay,
    required this.date,
    required this.onSelectDate,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: isActive ? () => onSelectDate(date) : null,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          height: 32,
          width: 32,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: isSelectedDay && isActive
                  ? Colors.yellow
                  : !isActive
                      ? Colors.grey
                      : Colors.transparent,
            ),
            child: Text(date.day.toString().padLeft(2, '0')),
          ),
        ),
      ),
    );
  }
}
