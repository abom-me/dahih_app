import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:khlfan_shtain/utils/enum/task_status_enum.dart';
import 'package:khlfan_shtain/utils/global_keys.dart';

import '../auto_local/lang.dart';
import '../components/alerts.dart';
import '../models/tasks_model.dart';

final tasksViewModelProvider = ChangeNotifierProvider<TasksViewModel>((ref) {
  return TasksViewModel();
});

class TasksViewModel with ChangeNotifier {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  DateTime selectedDate = DateTime.now();
  TaskStatusEnum selectedStatus = TaskStatusEnum.inProgress;

  changeSelectedDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  changeSelectedStatus(TaskStatusEnum status) {
    selectedStatus = status;
    notifyListeners();
  }
  List<Tasks> tasks = [];

  Future<List<Tasks>> getTodayTasks() async {
    List<Tasks> todayTasks = [];
    final value = await firebaseFirestore
        .collection("tasks")
        .doc(userData.uid)
        .collection("tasks")
        .get();
    tasks.clear();
    for (var element in value.docs) {

      tasks.add(Tasks.fromJson(element.data()));

      notifyListeners();
      todayTasks.add(Tasks.fromJson(element.data()));
    }

    notifyListeners();
    return todayTasks;
  }


  Future<List<Tasks>> getSelectedTasks() async {
    List<Tasks> allTasks = await getTodayTasks();
    List<Tasks> filteredTasks = [];
    for (var element in allTasks) {

      if (element.date == selectedDate.toString() &&
          element.status == TaskStatusEnum.inProgress.status) {
        filteredTasks.add(element);
      }
    }
    return filteredTasks;
  }

  List<String> tasksDates() {
    List<String> dates = [];

    for (var element in tasks) {
      if (!dates.contains(element.date)) {
        final date = DateTime.parse(element.date!);

        dates.add(DateFormat("yyyy/MM/dd").format(date));
      }
    }

    return dates;
  }

  Map<String, dynamic> countTaskTimeLeft(DateTime endTime) {
    var now = DateTime.now();

    int differenceInDays = endTime.difference(now).inDays.abs();
    int totalDays =
        DateTime(now.year, 12, 31).difference(DateTime(now.year, 1, 1)).inDays;

    double percentage = (totalDays / differenceInDays) * 100;

    var progress = percentage * 0.0001;

// if have more then 24 hours show in days else show in hours and minutes if its done show 0
    if (endTime.difference(now).inHours > 24) {
      var totalDuration = endTime.difference(now).inDays;
      return {"time": totalDuration, "unit": "يوم", "progress": progress};
    } else if (endTime.difference(now).inHours < 1) {
      var totalDuration = endTime.difference(now).inMinutes;
      return {"time": totalDuration, "unit": "دقيقة", "progress": progress};
    } else if (endTime.difference(now).inHours < 0) {
      var totalDuration = 0;
      return {"time": totalDuration, "unit": "دقيقة", "progress": progress};
    } else {
      var totalDuration = endTime.difference(now).inHours;
      return {"time": totalDuration, "unit": "ساعة", "progress": progress};
    }
  }

  changeTaskStatus({required Tasks task, required TaskStatusEnum status}) async {


  await  firebaseFirestore
        .collection("tasks")
        .doc(userData.uid)
        .collection("tasks")
        .doc(task.id)
        .update({"status": status.status});

  firebaseFirestore.collection("doneTasks").doc(userData.uid).set({
    "id": task.id,
    "name": task.task,
    "endDate": task.date,
    "doneIn": DateTime.now().toString(),
    "type": task.category,
    "userId": userData.uid,
  });
  }

  addTask(BuildContext context, {required Tasks task}) async {
    try {
      Alert.loading(context, "جاري اضافة المهمة");
      await firebaseFirestore
          .collection('tasks')
          .doc(userData.uid)
          .collection("tasks")
          .doc("${task.id}")
          .set(task.toJson());
      Alert.close(context);
      Alert.close(context);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<List<Tasks>> getTasksByType(TaskStatusEnum status) async {
    List<Tasks> allTasks = await getTodayTasks();

    switch (status) {
      case TaskStatusEnum.completed:
        List<Tasks> completedTasks = allTasks
            .where((element) => element.status == TaskStatusEnum.completed.status)
            .toList();
        completedTasks.sort((a, b) => a.date!.compareTo(b.date!));
        return completedTasks;
        break;
      case TaskStatusEnum.inProgress:
        List<Tasks> inProgressTasks = allTasks
            .where(
                (element) => element.status == TaskStatusEnum.inProgress.status)
            .toList();
        inProgressTasks.sort((a, b) => a.date!.compareTo(b.date!));
        return inProgressTasks;
        break;
      case TaskStatusEnum.all:
        allTasks.sort((a, b) => a.date!.compareTo(b.date!));
        allTasks.sort((a, b) {

          if (a.status == TaskStatusEnum.inProgress.status  && b.status != TaskStatusEnum.inProgress.status ) {
            return -1;
          } else if (a.status != TaskStatusEnum.inProgress.status  && b.status == TaskStatusEnum.inProgress.status) {
            return 1;
          } else {
            return 0;
          }

        });
        return allTasks;
        break;
    }
  }


  deleteTask({required BuildContext context , required Tasks task}) async {
    try {
      // Alert.loading(context, Lang.get(context, key: LangKey.deletingTask));
      await firebaseFirestore
          .collection('tasks')
          .doc(userData.uid)
          .collection("tasks")
          .doc("${task.id}")
          .delete();
      // Alert.close(context);
      // notifyListeners();
    } catch (e) {
      Alert.msg(context, Lang.get(context, key: LangKey.error), e.toString());
      print(e);
    }

  }
}
