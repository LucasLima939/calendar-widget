import 'package:flutter/material.dart';

class CalendarGridHeader extends StatelessWidget {
  CalendarGridHeader({super.key});
  final List<String> daysOfWeek = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        daysOfWeek.length,
        (index) => Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            alignment: Alignment.center,
            child: Text(daysOfWeek[index]),
          ),
        ),
      ),
    );
  }
}
