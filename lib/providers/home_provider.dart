

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khlfan_shtain/models/tasks_model.dart';
import 'package:khlfan_shtain/viewmodel/home_viewmodel.dart';

import '../models/course_model.dart';
import '../utils/enum/course_status_enum.dart';
final homeProvider = Provider<HomeProvider>((ref) {

  return HomeProvider(homeViewModel: ref.watch(homeViewModelProvider));
});
class HomeProvider{
  HomeViewModel homeViewModel;

  HomeProvider({required this.homeViewModel});

  Future<List<Course>> getTodayCourses() async {
    List<Course> todayCourses = [];

    return await homeViewModel.getTodayCourses();
  }

  double getCourseProgress(DateTime startTime,DateTime endTime) {
    return homeViewModel.getCourseProgress(startTime, endTime);
  }

  CourseStatusEnum isCourseInProgress(DateTime startTime,DateTime endTime) {
    return homeViewModel.isCourseInProgress(startTime, endTime);
  }

  Stream<int> getCourseTimeLeft(DateTime endTime) {
    return homeViewModel.getCourseTimeLeft(endTime);
  }

  Future<List<Tasks>> getTasks() async {
    return await homeViewModel.getTasks();
  }


  Map<String,dynamic> countTaskTimeLeft(DateTime endTime) {
    return homeViewModel.countTaskTimeLeft(endTime);
  }


}