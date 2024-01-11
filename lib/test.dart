// import 'package:flutter/material.dart';
// import 'package:khlfan_shtain/repo/courses.dart';
// import 'package:khlfan_shtain/utils/day_to_arabic.dart';
// import 'package:khlfan_shtain/utils/enum/days_enum.dart';
//
// import 'auto_local/lang.dart';
// import 'models/course_model.dart';
//
//
//
// enum DaysEnum {
//   monday('Monday'),
//   tuesday('Tuesday'),
//   wednesday('Wednesday'),
//   thursday('Thursday'),
//   friday('Friday'),
//   saturday('Saturday'),
//   sunday('Sunday');
//   const DaysEnum(this.name);
//   final String name;
// }
//
// class TimetableScreen extends StatefulWidget {
//   @override
//   _TimetableScreenState createState() => _TimetableScreenState();
// }
//
// class _TimetableScreenState extends State<TimetableScreen> {
//   List<String> daysOfWeek = [
//     DaysEnum.sunday.name,
//     DaysEnum.monday.name,
//     DaysEnum.tuesday.name,
//     DaysEnum.wednesday.name,
//     DaysEnum.thursday.name,
//     DaysEnum.friday.name,
//   ];
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Timetable'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Table(
//
//               // defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
//               // border: TableBorder.all(),
//               children: [
//                 // Header row with day names
//                 TableRow(
//                   decoration: BoxDecoration(
//                     color: Theme.of(context).primaryColor,
//                   ),
//                   children: daysOfWeek
//                       .where((day) =>
//                       courses.any((course) => course.days!.contains(day)))
//                       .map((day) {
//                     return TableCell(
//                       child: Container(
//                         padding: EdgeInsets.all(8.0),
//                         child: Text(Lang.get(context, key: day.dayToLangKey),style: TextStyle(color: Theme.of(context).colorScheme.background),)
//                       ),
//                     );
//                   }).toList(),
//                 ),
//
//                 // Data rows
//                 ..._buildDataRows(),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   List<TableRow> _buildDataRows() {
//     Map<String, List<Course>> coursesByDay = {};
//
//     for (var day in daysOfWeek
//         .where((day) => courses.any((course) => course.days!.contains(day)))) {
//       coursesByDay[day] =
//           courses.where((course) => course.days!.contains(day)).toList();
//     }
//
//     // Sort courses within each day based on start time
//     for (var entry in coursesByDay.entries) {
//       entry.value.sort(
//             (a, b) => a.from!.compareTo(b.from!),
//       );
//     }
//
//     int maxCourses = 0;
//     for (var entry in coursesByDay.entries) {
//       maxCourses = entry.value.length > maxCourses
//           ? entry.value.length
//           : maxCourses;
//     }
//
//     List<TableRow> dataRows = [];
//     for (int i = 0; i < maxCourses; i++) {
//       List<Widget> cells = daysOfWeek
//           .where((day) => courses.any((course) => course.days!.contains(day)))
//           .map((day) => TableCell(
//         verticalAlignment: TableCellVerticalAlignment.top,
//         child: Container(
//           decoration: BoxDecoration(
//             border: Border(
//               bottom: BorderSide(
//                 color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
//                 width: 1,
//               ),
//             ),
//           ),
//             alignment: AlignmentDirectional.topStart,
//           padding: EdgeInsets.all(8.0),
//           child: i < coursesByDay[day]!.length
//               ? Column(
//                 children: [
//                   Text(
//                   '${coursesByDay[day]![i].name}\n${coursesByDay[day]![i].room}'),
//                   Text(
//                     coursesByDay[day]?[i].from
//                         ?? 'null',
//                   ),
//                 ],
//               )
//               : Container(),
//         ),
//       ))
//           .toList();
//
//       dataRows.add(TableRow(children: cells));
//     }
//
//     return dataRows;
//   }
// }