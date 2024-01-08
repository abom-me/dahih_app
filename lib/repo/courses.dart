
import 'package:flutter/material.dart';

import '../models/course_model.dart';

List<Course> courses=[
  Course(
    name: 'ويب ٢',
    description: 'Mathematics',
    room: 'A209',
    teacher: 'دكتور سالم',
    from: "8:00",
    to: "10:00",
    days: ['Monday','Wednesday','Friday'],
    id: '1',
    color: '#FFC107',
  ),
  Course(
    name: 'داتابيس',
    description: 'Mathematics',
    room: 'A208',
      teacher: 'دكتور احمد',
      from: "10:00",
      to: "12:00",
    days: ['Monday','Wednesday','Friday'],
    id: '1',
    color: '#FFC107',
  ),
  Course(
    name: 'جافا',
    description: 'وصف',
    room: 'A110',
    teacher: 'استاذ خالد',
    from: "12:00",
    to: "14:00",
    days: ['Monday','Wednesday','Friday'],
    id: '2',
    color: '#FF5722',
  ),


];