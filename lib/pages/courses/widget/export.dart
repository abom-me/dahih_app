import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales2/flutter_locales2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khlfan_shtain/auto_local/lang.dart';
import 'package:khlfan_shtain/models/course_model.dart';
import 'package:khlfan_shtain/utils/day_to_arabic.dart';
import 'package:khlfan_shtain/utils/string_to_time.dart';

import '../../../providers/course_table_provider.dart';
import '../../../settings/theme.dart';
import '../../../utils/convert_widget_to_image.dart';
import '../../../utils/enum/days_enum.dart';
import '../../../utils/enum/gender_enum.dart';
import '../../../utils/global_keys.dart';

class CourseExport extends ConsumerStatefulWidget {
  const CourseExport(this.courses, {super.key});
final  List<Course> courses;
  @override
  ConsumerState createState() => _CourseExportState();
}

class _CourseExportState extends ConsumerState<CourseExport> {
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
List<Course> courses = widget.courses;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          convertWidget(
              widget: Material(

                textStyle: const TextStyle(fontFamily:"IBM Plex Sans Arabic" ),
            child:   Theme(
              data: ThemeData(
                textTheme:const TextTheme(
                  /// all text style have this color 002055
                  // bodyLarge: TextStyle(color: Color(0xff002055)),
                  // bodyMedium: TextStyle(color: Color(0xff002055)),
                  // labelLarge: TextStyle(color: Color(0xff002055)),
                  // bodySmall: TextStyle(color: Color(0xff002055)),
                  // displayLarge: TextStyle(color: Color(0xff002055)),
                  // displayMedium: TextStyle(color: Color(0xff002055)),
                  // displaySmall: TextStyle(color: Color(0xff002055)),
                  // headlineMedium: TextStyle(color: Color(0xff002055)),
                  // headlineSmall: TextStyle(color: Color(0xff002055)),
                  // titleLarge: TextStyle(color: Color(0xff002055)),



                ),
                appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  iconTheme: IconThemeData(color: Color(0xff002055)),

                ),
                scaffoldBackgroundColor: Colors.white,
                fontFamily: "IBM Plex Sans Arabic",useMaterial3: true, colorScheme: MaterialTheme.lightMediumContrastScheme().toColorScheme(),),

              child: Directionality(
                textDirection: Locales.lang == "ar" ? TextDirection.rtl : TextDirection.ltr,
                child: Container(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                  width: 500,
                  height: 500,
                  child:   Stack(
                    children: [

                      Table(


                        children: [
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
                          ..._buildDataRows(courses,ref,context),
                        ],
                      ),
                      Positioned(
                        bottom: 0,
                        child: Row(
                          children: [
                            userData.profileImage=="" || userData.profileImage==null ? userData.gender==GenderEnum.male.gender?Image.asset(

                              "assets/avatars/i5.png",
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ):Image.asset(

                              "assets/avatars/i43.png",
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ): Image.asset(
                              "assets/avatars/${userData.profileImage}",
                              fit: BoxFit.cover,
                              width: 150,
                              height: 150,
                            ),

                            Text(userData.name,style: const TextStyle(fontSize: 25,fontWeight: FontWeight.w500),
                            ),

                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ), onCreate: (f,g){
            print(f.path);
            print(g.path);
          });
          // GoPage.push(page: CourseExport(), context: context);
          // bottomSheetBlur(context, widget: const AddCourse(), height: 600, color: Theme.of(context).colorScheme.background,);
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        decoration: BoxDecoration(

        ),

        child: Column(
mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Container(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
            width: 500,
            height: 500,
            child:   Stack(
              children: [

                Table(


                  children: [
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
                    ..._buildDataRows(courses,ref,context),
                  ],
                ),
                Positioned(
                  bottom: 0,
                    child: Row(
                      children: [
                        userData.profileImage=="" || userData.profileImage==null ? userData.gender==GenderEnum.male.gender?Image.asset(

                          "assets/avatars/i5.png",
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ):Image.asset(

                          "assets/avatars/i43.png",
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ): Image.asset(
                          "assets/avatars/${userData.profileImage}",
                          fit: BoxFit.cover,
                          width: 150,
                          height: 150,
                        ),

                        Text(userData.name,style: const TextStyle(fontSize: 25,fontWeight: FontWeight.w500),
                        ),

                      ],
                    ),
                )
              ],
            ),
          )
          ],
        ),

      ),
    );
  }

  List<TableRow> _buildDataRows(List<Course> courses, WidgetRef ref, BuildContext context) {
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
              ? InkWell(

            child: Container(

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