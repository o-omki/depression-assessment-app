import 'package:intl/intl.dart';
List<String> elig = ["Monday", "Wednesday", "Friday"];

DateTime findClosestMatchingDay(List<String> eligibleDays) {
  DateTime currentDate = DateTime.now();

  // Find the closest future date that matches one of the eligible days
  DateTime closestDate = currentDate;
  while (!eligibleDays.contains(DateFormat('EEEE').format(closestDate))) {
    closestDate = closestDate.add(Duration(days: 1));
  }

  return closestDate;
}

void main() {
  DateTime appointmentDate = findClosestMatchingDay(elig);
  print(appointmentDate); // Print the closest matching date
}
