import 'package:flutter/material.dart';
import 'package:glucose_guardian/constants/colors.dart';
import 'package:intl/intl.dart';

/// Day selector component
///
/// Let's the user select the day to visualize data, returns to parent the
/// selected day using [callback].
class DaySelector extends StatefulWidget {
  final Function(DateTime)? callback;
  const DaySelector({super.key, this.callback});

  @override
  State<DaySelector> createState() => _DaySelectorState();
}

class _DaySelectorState extends State<DaySelector> {
  final DateTime today = DateTime.now();
  DateTime? _selectedDate;

  final BorderRadius borderRadius = BorderRadius.circular(64);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        for (int i = 0; i < 7; i++) _buildDaySelectorComponent(i),
      ].reversed.toList(), // so the days will go backwards
    );
  }

  Widget _buildDaySelectorComponent(int i) {
    DateTime workingDate = today;
    if (i != 0) workingDate = today.subtract(Duration(days: i));

    final bool selected = (_selectedDate ?? today) == workingDate;

    return InkWell(
      borderRadius: borderRadius,
      onTap: () {
        if (widget.callback != null) widget.callback!(workingDate);
        return setState(() => _selectedDate = workingDate);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: selected ? 100 : 30,
        height: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? Theme.of(context).primaryColor : kBackgroundColor,
          borderRadius: borderRadius,
        ),
        child: Text(
          selected
              ? "${workingDate == today ? 'Oggi ' : ''}${DateFormat("dd MMM", 'it').format(workingDate)}"
              : workingDate.day.toString(),
          maxLines: 1,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.clip,
          ),
        ),
      ),
    );
  }
}
