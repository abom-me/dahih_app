


import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    if (element.days!.contains(DateTime.now().weekday)){
      todayCourses.add(element);
    }
  });
  return todayCourses;
}

double getCourseProgress(DateTime startTime,DateTime endTime) {
  var now = DateTime.now();
  var start = startTime;
  var end = endTime;
  var totalDuration = end
      .difference(start)
      .inMinutes;
  var passedDuration = now
      .difference(start)
      .inMinutes;
  var progress = passedDuration / totalDuration;

  return progress;
}

CourseStatusEnum isCourseInProgress(DateTime startTime,DateTime endTime) {
  var now = DateTime.now();
  var start = startTime;
  var end = endTime;
  var totalDuration = end
      .difference(start)
      .inMinutes;
  var passedDuration = now
      .difference(start)
      .inMinutes;
  var progress = passedDuration / totalDuration;

  if (progress < 0) {
    return CourseStatusEnum.notStarted;
  } else if (progress > 1) {
    return CourseStatusEnum.finished;
  } else {
    return CourseStatusEnum.inProgress;
  }
}


Stream<int> getCourseTimeLeft(DateTime endTime) {
  var controller = StreamController<int>();

  void updateTime() {
    var now = DateTime.now();
    var totalDuration = endTime.difference(now).inMinutes;
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
    return {"time":totalDuration,"unit":"دقيقة","progress":1.0};

  }else{


    if(endTime.difference(now).inHours > 24){

      int differenceInDays = endTime.difference(now).inDays.abs();
      int totalDays = DateTime(now.year, 12, 31).difference(DateTime(now.year, 1, 1)).inDays;

      double percentage = (totalDays / differenceInDays) * 100;

      var progress=percentage*0.0001;
      var totalDuration = endTime.difference(now).inDays;
      return {"time":totalDuration,"unit":"يوم","progress":progress};
    }else if(endTime.difference(now).inHours < 1){

      int differenceInDays = endTime.difference(now).inMinutes.abs();
      int totalDays = DateTime(now.year, 12, 31).difference(DateTime(now.year, 1, 1)).inMinutes;

      double percentage = (totalDays / differenceInDays) * 100;

      var progress=percentage*0.0001;
      var totalDuration = endTime.difference(now).inMinutes;
      return {"time":totalDuration,"unit":"دقيقة","progress":progress};
    } else{

      int differenceInDays = endTime.difference(now).inSeconds.abs();
      int totalDays = DateTime(now.year, 12, 31).difference(DateTime(now.year, 1, 1)).inSeconds;

      double percentage = (totalDays / differenceInDays) * 100;

      var progress=percentage*0.0001;
      var totalDuration = endTime.difference(now).inHours;


      return {"time":totalDuration,"unit":"ساعة","progress":progress};
    }
  }

  }




}