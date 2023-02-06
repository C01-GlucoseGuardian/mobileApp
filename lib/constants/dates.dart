final DateTime now = DateTime.now();
final DateTime lastMidnight = DateTime(now.year, now.month, now.day);

List<DateTime> getDayTimeSpan(DateTime day) {
  final DateTime start = DateTime(day.year, day.month, day.day);
  final DateTime end = start.add(
    const Duration(
      hours: 23,
      minutes: 59,
      seconds: 59,
    ),
  );

  return [start, end];
}
