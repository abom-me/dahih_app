import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khlfan_shtain/models/exam_model.dart';
import 'package:khlfan_shtain/viewmodel/exams_viewmodel.dart';

final examsProvider = ChangeNotifierProvider<ExamsProvider>((ref) {
  return ExamsProvider();
});
class ExamsProvider with ChangeNotifier{
  ExamsViewModel examsViewModel=ExamsViewModel();
  addExam(BuildContext context,{required Exams exam}) async {
examsViewModel.addExam(context,exam: exam);
notifyListeners();
  }

  Future<List<Exams>>getExams()  async {

    return await examsViewModel.getExams();
  }

  deleteExam(BuildContext context,{required String id}) async {

    examsViewModel.deleteExam(context, id: id);
    notifyListeners();
  }


}