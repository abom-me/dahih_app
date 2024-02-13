


import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khlfan_shtain/models/course_model.dart';
import 'package:khlfan_shtain/viewmodel/course_table_viewmode.dart';

final courseTableProvider= Provider<CourseTableProvider>((ref){
  return CourseTableProvider();
});
class CourseTableProvider{
  CourseTableViewModel courseTableViewModel=CourseTableViewModel();


  Future<List<Course>> getCourseTable() async {

    return await courseTableViewModel.getTimeTable();
  }

  addCourse(BuildContext  context,Course course) async {
    await courseTableViewModel.addCourse(context,course);
  }

  deleteCourse(BuildContext context,String id) async {

    await courseTableViewModel.deleteCourse(context,id);
  }

  resetNotification(BuildContext context,Course course) async {
    await courseTableViewModel.resetNotification(context,course);
  }
}