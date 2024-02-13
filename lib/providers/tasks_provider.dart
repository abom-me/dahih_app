

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/tasks_model.dart';
import '../utils/enum/task_status_enum.dart';
import '../viewmodel/tasks_viewmodel.dart';

final tasksProvider = ChangeNotifierProvider<TasksProvider>((ref) {
  return TasksProvider(tasksViewModel: ref.watch(tasksViewModelProvider));
});

class TasksProvider with ChangeNotifier{
  TasksViewModel tasksViewModel;

  TasksProvider({required this.tasksViewModel});

 getTodayTasks() async {
    return await tasksViewModel.getTodayTasks();
  }

  changeSelectedDate(DateTime date) {
    tasksViewModel.selectedDate = date;
    notifyListeners();
  }

  changeTaskStatus(Tasks task,TaskStatusEnum status){
    tasksViewModel.changeTaskStatus(task: task,status: status);
    notifyListeners();
  }

  addTask(BuildContext context,Tasks task){
    tasksViewModel.addTask(context,task: task);
    notifyListeners();
  }

  Future<List<Tasks>> getSelectedTasks() async {
    return await tasksViewModel.getSelectedTasks();
  }

  List<String> tasksDates(){


    return tasksViewModel.tasksDates();
  }

  changeSelectedStatus(TaskStatusEnum status) {
    tasksViewModel.selectedStatus = status;
    notifyListeners();
  }

 TaskStatusEnum getSelectedStatus() {
   return tasksViewModel.selectedStatus ;
  }



  Future<List<Tasks>> getTasksByType(TaskStatusEnum status) async {
    return await tasksViewModel.getTasksByType(status);
  }

  deleteTask({required BuildContext context,required Tasks task}){
    tasksViewModel.deleteTask(context:context,task: task);
    notifyListeners();
  }
}