


import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:khlfan_shtain/auto_local/lang.dart';
import 'package:khlfan_shtain/models/tasks_model.dart';
import 'package:khlfan_shtain/repo/courses.dart';
import 'package:khlfan_shtain/utils/global_keys.dart';

import '../models/course_model.dart';
import '../repo/tasks.dart';
import '../utils/enum/course_status_enum.dart';

final homeViewModelProvider = Provider<HomeViewModel>((ref) {
  return HomeViewModel();
});
class HomeViewModel{
FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
Future<List<Course>> getTodayCourses() async {
List<Course> todayCourses = [];
//make Future delay to simulate network call
await Future.delayed(const Duration(seconds: 2));

  courses.forEach((element) {
    if (element.days!.contains(DateFormat('EEEE').format(DateTime.now()))){
      todayCourses.add(element);
    }
  });
  return todayCourses;
}

// double getCourseProgress(DateTime startTime,DateTime endTime) {
//   var now = DateTime.now();
//   var start = startTime;
//   var end = endTime;
//   var totalDuration = end
//       .difference(start)
//       .inMinutes;
//   var passedDuration = now
//       .difference(start)
//       .inMinutes;
//   var progress = passedDuration / totalDuration;
//
//   return progress;
// }


  double getCourseProgress(TimeOfDay startTime, TimeOfDay endTime) {
    TimeOfDay now = TimeOfDay.fromDateTime(DateTime.now());
    int startMinutes = startTime.hour * 60 + startTime.minute;
    int endMinutes = endTime.hour * 60 + endTime.minute;
    int nowMinutes = now.hour * 60 + now.minute;

    int totalDuration = endMinutes - startMinutes;
    int passedDuration = nowMinutes - startMinutes;

    double progress = passedDuration / totalDuration;
    return progress;
  }

CourseStatusEnum isCourseInProgress(TimeOfDay startTime,TimeOfDay endTime) {
  TimeOfDay now = TimeOfDay.fromDateTime(DateTime.now());
  int startMinutes = startTime.hour * 60 + startTime.minute;
  int endMinutes = endTime.hour * 60 + endTime.minute;
  int nowMinutes = now.hour * 60 + now.minute;

  int totalDuration = endMinutes - startMinutes;
  int passedDuration = nowMinutes - startMinutes;

  double progress = passedDuration / totalDuration;

  if (progress < 0) {
    return CourseStatusEnum.notStarted;
  } else if (progress > 1) {
    return CourseStatusEnum.finished;
  } else {
    return CourseStatusEnum.inProgress;
  }
}


// Stream<int> getCourseTimeLeft(DateTime endTime) {
//   var controller = StreamController<int>();
//
//   void updateTime() {
//     var now = DateTime.now();
//     var totalDuration = endTime.difference(now).inMinutes;
//     controller.add(totalDuration);
//   }
//
//
//   Timer.periodic(const Duration(seconds: 1), (timer) {
//     updateTime();
//   });
//
//
//   updateTime();
//
//   return controller.stream;
// }

  Stream<int> getCourseTimeLeft(TimeOfDay endTime) {
    StreamController<int> controller = StreamController<int>();

    void updateTime() {
      TimeOfDay now = TimeOfDay.fromDateTime(DateTime.now());
      int endMinutes = endTime.hour * 60 + endTime.minute;
      int nowMinutes = now.hour * 60 + now.minute;

      int totalDuration = endMinutes - nowMinutes;
      controller.add(totalDuration);
    }

    Timer.periodic(const Duration(seconds: 1), (timer) {
      updateTime();
    });

    updateTime();

    return controller.stream;
  }


Future<List<Tasks>> getTasks() async {
  List<Tasks> tasksList = [];
 final data=await firebaseFirestore.collection("tasks").doc(userData.uid).collection('tasks').get();

  data.docs.forEach((element) {

    tasksList.add(Tasks.fromJson(element.data()));
  });
  // tasksList.sort((a, b) => a.date!.compareTo(b.date!));
  // print(tasksList.length);
  return tasksList;
}

Map<String,dynamic>countTaskTimeLeft(DateTime endTime) {
var now = DateTime.now();


// if have more then 24 hours show in days else show in hours and minutes
  if(endTime.isBefore(now)){

    var totalDuration = 0;
    return {"time":totalDuration,"unit":LangKey.minute,"progress":1.0};

  }else{


    if(endTime.difference(now).inHours > 24){

      int differenceInDays = endTime.difference(now).inDays.abs();
      int totalDays = DateTime(now.year, 12, 31).difference(DateTime(now.year, 1, 1)).inDays;

      double percentage = (totalDays / differenceInDays) * 100;

      var progress=percentage*0.0001;
      var totalDuration = endTime.difference(now).inDays;
      return {"time":totalDuration,"unit":LangKey.day,"progress":progress};
    }else if(endTime.difference(now).inHours < 1){

      int differenceInDays = endTime.difference(now).inMinutes.abs();
      int totalDays = DateTime(now.year, 12, 31).difference(DateTime(now.year, 1, 1)).inMinutes;

      double percentage = (totalDays / differenceInDays) * 100;

      var progress=percentage*0.0001;
      var totalDuration = endTime.difference(now).inMinutes;
      return {"time":totalDuration,"unit":LangKey.minute,"progress":progress};
    } else{

      int differenceInDays = endTime.difference(now).inSeconds.abs();
      int totalDays = DateTime(now.year, 12, 31).difference(DateTime(now.year, 1, 1)).inSeconds;

      double percentage = (totalDays / differenceInDays) * 100;

      var progress=percentage*0.0001;
      var totalDuration = endTime.difference(now).inHours;


      return {"time":totalDuration,"unit":LangKey.hours,"progress":progress};
    }
  }

  }




}