import 'package:flutter/material.dart';

class HeaderComponent extends StatefulWidget {
  final DateTime focusedDay;
  final void Function(DateTime) onUpdateFocusedDay;
  const HeaderComponent({
    super.key,
    required this.focusedDay,
    required this.onUpdateFocusedDay,
  });

  @override
  State<HeaderComponent> createState() => _HeaderComponentState();
}

class _HeaderComponentState extends State<HeaderComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12 * 0.9),
      child: Row(
        children: [
          Text('${_getMonthName(widget.focusedDay.month)} ${widget.focusedDay.year}'),
          const Spacer(),
          _iconButton(Icons.arrow_back_ios,
              onPressed: () =>
                  widget.onUpdateFocusedDay(DateTime(widget.focusedDay.year, widget.focusedDay.month - 1, 1))),
          const SizedBox(width: 24),
          _iconButton(Icons.arrow_forward_ios,
              onPressed: () =>
                  widget.onUpdateFocusedDay(DateTime(widget.focusedDay.year, widget.focusedDay.month + 1, 1))),
          const SizedBox(width: 4),
        ],
      ),
    );
  }

  Widget _iconButton(IconData icon, {required VoidCallback onPressed}) => ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: Colors.blueAccent,
          elevation: 0,
          padding: const EdgeInsets.all(0),
        ),
        child: Container(
          padding: const EdgeInsets.only(left: 4),
          child: Icon(icon, size: 16, color: Colors.white),
        ),
      );

  String _getMonthName(int month) {
    const monthNames = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return monthNames[month].toUpperCase();
  }
}
