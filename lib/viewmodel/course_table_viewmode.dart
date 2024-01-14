import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khlfan_shtain/components/alerts.dart';
import 'package:khlfan_shtain/models/course_model.dart';
import 'package:khlfan_shtain/utils/global_keys.dart';

import '../repo/courses.dart';

final courseTableViewModelProvider = ChangeNotifierProvider<CourseTableViewModel>((ref) {
  return CourseTableViewModel();
});
class CourseTableViewModel  with ChangeNotifier{
FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;

Future< List<Course>> getTimeTable() async {
  List<Course> todayCourses = [];
final value=await firebaseFirestore.collection('courses').doc(userData.uid).collection('courses').get();
  for (var element in value.docs) {
    todayCourses.add(Course.fromJson(element.data()));
  }


  return todayCourses;



  }

  addCourse(BuildContext context,Course course) async {
  Alert.loading(context, "title");
    await firebaseFirestore.collection('courses').doc(userData.uid).collection('courses').doc(course.id).set(course.toJson());
    notifyListeners();
  Alert.close(context);

}

}