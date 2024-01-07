
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

  Future<List<Tasks>> getTodayTasks() async {
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
}