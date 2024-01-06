
import '../models/course_model.dart';

List<Course> courses=[
  Course(
    name: 'ويب ٢',
    description: 'Mathematics',
    room: 'A209',
    teacher: 'دكتور سالم',
    from: DateTime.parse('2024-01-06 06:00:00'),
    to: DateTime.parse('2024-01-06 07:00:00'),
    days: ['Monday','Wednesday','Friday'],
    id: '1',
    color: '#FFC107',
  ),
  Course(
    name: 'داتابيس',
    description: 'Mathematics',
    room: 'A208',
    teacher: 'دكتور احمد',
    from: DateTime.parse('2024-01-06 08:00:00'),
    to: DateTime.parse('2024-01-06 11:00:00'),
    days: ['Monday','Wednesday','Friday'],
    id: '1',
    color: '#FFC107',
  ),
  Course(
    name: 'جافا',
    description: 'وصف',
    room: 'A110',
    teacher: 'استاذ خالد',
    from: DateTime.parse('2024-01-06 12:00:00'),
    to: DateTime.parse('2024-01-06 13:00:00'),
    days: ['Monday','Wednesday','Friday'],
    id: '2',
    color: '#FF5722',
  ),


];