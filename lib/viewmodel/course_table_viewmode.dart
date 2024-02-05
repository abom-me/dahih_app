import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khlfan_shtain/components/alerts.dart';
import 'package:khlfan_shtain/models/course_model.dart';
import 'package:khlfan_shtain/utils/enum/days_enum.dart';
import 'package:khlfan_shtain/utils/string_to_time.dart';
import 'package:khlfan_shtain/viewmodel/local_storage_viewmodel.dart';

import '../auto_local/lang.dart';
import '../utils/notification/notification_config.dart';

final courseTableViewModelProvider = ChangeNotifierProvider<CourseTableViewModel>((ref) {
  return CourseTableViewModel();
});
class CourseTableViewModel  with ChangeNotifier{

LocalStorageViewModel local=LocalStorageViewModel();
NotificationConfig notf=NotificationConfig();
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
for(var courseDays in course.days!){
  TimeOfDay time=course.from.toString().toTimeOfDay;
  DateTime scheduledDate=DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,time.hour,time.minute);
  notf.scheduleNotification(body:" 📚 ${Lang.get(context, key: LangKey.courseName)}: ${course.name} 🏠 ${Lang.get(context, key: LangKey.roomNo)}: ${course.room} " , title: Lang.get(context, key: LangKey.yourCourseWillStart), id: extractNumbers(course.id!), scheduledDate: scheduledDate, day: getDayOfWeek(courseDays));
}
    notifyListeners();
  Alert.close(context);

}

deleteCourse(BuildContext context,String id) async {
  Alert.close(context);
  Alert.loading(context, Lang.get(context, key: LangKey.deleting));
  await local.deleteData(collectionName: 'courses', docId: id);
  notf.cancelNotification(extractNumbers(id));
  notifyListeners();
  // Alert.close(context);
}

resetNotification(BuildContext context,Course course) async {
  Alert.close(context);

  await notf.cancelNotification(extractNumbers(course.id!));
  for(var courseDays in course.days!){
    TimeOfDay time=course.from.toString().toTimeOfDay;
    DateTime scheduledDate=DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,time.hour,time.minute);
    notf.scheduleNotification(body:" 📚 ${Lang.get(context, key: LangKey.courseName)}: ${course.name} 🏠 ${Lang.get(context, key: LangKey.roomNo)}: ${course.room} " , title: Lang.get(context, key: LangKey.yourCourseWillStart), id: extractNumbers(course.id!), scheduledDate: scheduledDate, day: getDayOfWeek(courseDays));
  }
  Alert.snackbar(context, text:Lang.get(context, key: LangKey.resetNotification));
  notifyListeners();
}

int extractNumbers(String inputString) {
  RegExp regExp = RegExp(r'\d+');
  Iterable<RegExpMatch> matches = regExp.allMatches(inputString);

  String result="";

  for (RegExpMatch match in matches) {
    result += match.group(0)!;
  }

  return int.parse(result.substring(0, 8));
}

}