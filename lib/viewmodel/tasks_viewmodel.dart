


import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:khlfan_shtain/repo/tasks.dart';
import 'package:khlfan_shtain/utils/enum/task_status_enum.dart';

import '../models/tasks_model.dart';
final tasksViewModelProvider = ChangeNotifierProvider<TasksViewModel>((ref) {
  return TasksViewModel();
});
class TasksViewModel  with ChangeNotifier{

  DateTime selectedDate=DateTime.now();
 changeSelectedDate(DateTime date) {
   selectedDate = date;
   notifyListeners();
 }
  Future<List<Tasks>> getTodayTasks() async {
// get tasks who have the same date as selected date
    List<Tasks> todayTasks = [];
    tasks.forEach((element) {
      if (element.date!.day == selectedDate.day &&
          element.date!.month == selectedDate.month &&
          element.date!.year == selectedDate.year && element.status==TaskStatusEnum.inProgress.status) {
        todayTasks.add(element);
      }
    });
//make Future delay to simulate network call


   await Future.delayed(const Duration(seconds: 2));

    return todayTasks;
  }


  Map<String,dynamic>countTaskTimeLeft(DateTime endTime) {
    var now = DateTime.now();


    int differenceInDays = endTime.difference(now).inDays.abs();
    int totalDays = DateTime(now.year, 12, 31).difference(DateTime(now.year, 1, 1)).inDays;

    double percentage = (totalDays / differenceInDays) * 100;

    var progress=percentage*0.0001;

// if have more then 24 hours show in days else show in hours and minutes if its done show 0
    if(endTime.difference(now).inHours > 24){
      var totalDuration = endTime.difference(now).inDays;
      return {"time":totalDuration,"unit":"يوم","progress":progress};
    }else if(endTime.difference(now).inHours < 1){
      var totalDuration = endTime.difference(now).inMinutes;
      return {"time":totalDuration,"unit":"دقيقة","progress":progress};
    }
    else if(endTime.difference(now).inHours < 0){
      var totalDuration = 0;
      return {"time":totalDuration,"unit":"دقيقة","progress":progress};
    }
    else{
      var totalDuration = endTime.difference(now).inHours;
      return {"time":totalDuration,"unit":"ساعة","progress":progress};
    }
  }


  changeTaskStatus({required Tasks task,required TaskStatusEnum status}){
tasks.firstWhere((element) => element.id==task.id).status!="dasd";
print(tasks.firstWhere((element) => element.id==task.id).toJson());

    // task.status!=status.status;



  }



}