

import 'package:flutter/material.dart';

extension TimeOfDayExtension on String {
  TimeOfDay get toTimeOfDay {
    final format = split(':');
    return TimeOfDay(
        hour: int.parse(format[0]), minute: int.parse(format[1]));
  }
}

extension TimeOfDayExtension2 on TimeOfDay {
  String get toStringTime {
    return "$hour:$minute";
  }
}


