import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khlfan_shtain/components/alerts.dart';
import 'package:khlfan_shtain/models/course_model.dart';
import 'package:khlfan_shtain/utils/global_keys.dart';
import 'package:khlfan_shtain/viewmodel/local_storage_viewmodel.dart';

import '../auto_local/lang.dart';
import '../repo/courses.dart';

final courseTableViewModelProvider = ChangeNotifierProvider<CourseTableViewModel>((ref) {
  return CourseTableViewModel();
});
class CourseTableViewModel  with ChangeNotifier{
LocalStorageViewModel local=LocalStorageViewModel();
Future< List<Course>> getTimeTable() async {
  List<Course> todayCourses = [];
final Map<String,dynamic>value=await local.getData(collectionName: 'courses');
if(value['status'] != 'empty'){
 value.forEach((key, value) {
   todayCourses.add(Course.fromJson(value));
 });
}

  return todayCourses;



  }

  addCourse(BuildContext context,Course course) async {
  Alert.loading(context, Lang.get(context, key: LangKey.saving));
 print(course.toJson());
    await local.addData(collectionName: 'courses', data: course.toJson(), docID: course.id!);
    notifyListeners();
  Alert.close(context);

}

}