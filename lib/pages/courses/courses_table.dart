import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khlfan_shtain/components/bottom_sheet.dart';
import 'package:khlfan_shtain/pages/courses/widget/add_course.dart';
import 'package:khlfan_shtain/utils/day_to_arabic.dart';
import 'package:khlfan_shtain/utils/string_to_time.dart';

import '../../auto_local/lang.dart';
import '../../models/course_model.dart';
import '../../providers/course_table_provider.dart';
// import '../../repo/courses.dart';
import '../../utils/enum/days_enum.dart';

class CoursesTable extends ConsumerStatefulWidget {
  const CoursesTable({super.key});

  @override
  ConsumerState createState() => _CoursesTableState();
}

class _CoursesTableState extends ConsumerState<CoursesTable> {
  List<String> daysOfWeek = [
    DaysEnum.sunday.name,
    DaysEnum.monday.name,
    DaysEnum.tuesday.name,
    DaysEnum.wednesday.name,
    DaysEnum.thursday.name,
    DaysEnum.friday.name,
    DaysEnum.saturday.name
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
bottomSheetBlur(context, widget: const AddCourse(), height: 600, color: Theme.of(context).colorScheme.background,);
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(Lang.get(context, key: LangKey.studySchedule),style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),

      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: ref.read(courseTableProvider).getCourseTable(),
          builder: (context,snapshot){
      if(snapshot.hasData){
        List<Course>   courses=snapshot.data!;
        return  Table(

          // defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
          // border: TableBorder.all(),
          children: [
            // Header row with day names
            TableRow(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              children: daysOfWeek
                  .where((day) =>
                  courses.any((course) => course.days!.contains(day)))
                  .map((day) {
                return TableCell(
                  child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(Lang.get(context, key: day.dayToLangKey),style: TextStyle(color: Theme.of(context).colorScheme.background),)
                  ),
                );
              }).toList(),
            ),

            // Data rows
            ..._buildDataRows(courses),
          ],
        );
      }
      return Container();
          },
        ),
      ),
    );
  }

  List<TableRow> _buildDataRows(List<Course> courses) {
    Map<String, List<Course>> coursesByDay = {};
  courses.sort((a, b) {
    // convert to DateTime objects
    TimeOfDay aDate = a.from!.toTimeOfDay;
    TimeOfDay bDate = b.from!.toTimeOfDay;
    return aDate.hour.compareTo(bDate.hour);

  });
    for (var day in daysOfWeek
        .where((day) => courses.any((course) => course.days!.contains(day)))) {
      coursesByDay[day] =
          courses.where((course) => course.days!.contains(day)).toList();
    }

    // Sort courses within each day based on start time
    for (var entry in coursesByDay.entries) {

      entry.value.sort(

            (a, b) {
              TimeOfDay aDate = a.from!.toTimeOfDay;
              TimeOfDay bDate = b.from!.toTimeOfDay;
              return aDate.hour.compareTo(bDate.hour);
            },
      );
    }

    int maxCourses = 0;
    for (var entry in coursesByDay.entries) {
      maxCourses = entry.value.length > maxCourses
          ? entry.value.length
          : maxCourses;
    }

    List<TableRow> dataRows = [];
    for (int i = 0; i < maxCourses; i++) {
      List<Widget> cells = daysOfWeek
          .where((day) => courses.any((course) => course.days!.contains(day)))
          .map((day) => TableCell(
        verticalAlignment: TableCellVerticalAlignment.top,
        child: Container(

          child: i < coursesByDay[day]!.length
              ? Container(
            margin: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8.0),
            ),
            alignment: AlignmentDirectional.center,
            padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                Text(
                    '${coursesByDay[day]![i].name}\n${coursesByDay[day]![i].room}'),
                Text(
                  coursesByDay[day]?[i].from!.toTimeOfDay.format(context)
                      ??"",
                ),
                            ],
                          ),
              )
              : Container(),
        ),
      ))
          .toList();

      dataRows.add(TableRow(children: cells));
    }

    return dataRows;
  }
}
