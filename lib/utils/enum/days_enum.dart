
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

enum DaysEnum {
  monday('Monday'),
  tuesday('Tuesday'),
  wednesday('Wednesday'),
  thursday('Thursday'),
  friday('Friday'),
  saturday('Saturday'),
  sunday('Sunday');
  const DaysEnum(this.name);
  final String name;
}

/// String days to getDayOfWeek
 Day getDayOfWeek(String day) {
  switch (day) {
    case 'Monday':
      return Day.monday;
    case 'Tuesday':
      return Day.tuesday;
    case 'Wednesday':
      return Day.wednesday;
    case 'Thursday':
      return Day.thursday;
    case 'Friday':
      return Day.friday;
    case 'Saturday':
      return Day.saturday;
    case 'Sunday':
      return Day.sunday;
    default:
      return Day.monday;
  }
}