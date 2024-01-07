


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:khlfan_shtain/repo/tasks.dart';
import 'package:khlfan_shtain/utils/enum/task_status_enum.dart';
import 'package:khlfan_shtain/utils/global_keys.dart';

import '../components/alerts.dart';
import '../models/tasks_model.dart';
final tasksViewModelProvider = ChangeNotifierProvider<TasksViewModel>((ref) {
  return TasksViewModel();
});
class TasksViewModel  with ChangeNotifier{
FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
  DateTime selectedDate=DateTime.now();
 changeSelectedDate(DateTime date) {
   selectedDate = date;
   notifyListeners();
 }
  Future<List<Tasks>> getTodayTasks() async {
    List<Tasks> todayTasks = [];
 final value=await firebaseFirestore.collection("tasks").doc(userData.uid).collection("tasks").where("status",isEqualTo: TaskStatusEnum.inProgress.status).where("date",isEqualTo: selectedDate.toString()).get();

     value.docs.forEach((element) {
notifyListeners();
      todayTasks.add(Tasks.fromJson(element.data()));
    });

    // });
//make Future delay to simulate network call

    notifyListeners();


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
// tasks.firstWhere((element) => element.id==task.id).status!="dasd";
// print(tasks.firstWhere((element) => element.id==task.id).toJson());

    // task.status!=status.status;
    print("start");
firebaseFirestore.collection("tasks").doc(userData.uid).collection("tasks").doc(task.id).update(
  {
    "status":status.status
  }
);


  }


  addTask(BuildContext context,{required Tasks task}) async {
 try{
   Alert.loading(context, "جاري اضافة المهمة");
  await firebaseFirestore.collection('tasks').doc(userData.uid).collection("tasks").doc("${task.id}").set(task.toJson());
    Alert.close(context);
    Alert.close(context);
  notifyListeners();
 }catch(e){
   print(e);
 }

  }



}