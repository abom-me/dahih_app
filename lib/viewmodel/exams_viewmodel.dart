import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khlfan_shtain/components/alerts.dart';
import 'package:khlfan_shtain/viewmodel/local_storage_viewmodel.dart';

import '../auto_local/lang.dart';
import '../models/exam_model.dart';

final examsViewModelProvider = ChangeNotifierProvider<ExamsViewModel>((ref) {
  return ExamsViewModel();
});

class ExamsViewModel extends ChangeNotifier {
  LocalStorageViewModel local=LocalStorageViewModel();
  addExam(BuildContext context,{required Exams exam}) async {
    Alert.loading(context, Lang.get(context, key: LangKey.saving));
  try{

    await local.addData(collectionName: 'exams', data: exam.toJson(), docID: exam.examID);
    notifyListeners();
    Navigator.pop(context);
    Navigator.pop(context);
    notifyListeners();
  }catch(e){
    Navigator.pop(context);

    Alert.msg(context, Lang.get(context, key: LangKey.error), e.toString());
  }


  }

  Future<List<Exams>>getExams()  async{

    List<Exams> exams=[];
    final  data = await local.getData(collectionName: "exams");


if(data['status'] != 'empty'){
  data.forEach((key, value) {
    exams.add(Exams.fromJson(value));
  });
  exams.sort((a,b)=>b.examDate.compareTo(a.examDate));

}

    return exams;

  }

  deleteExam(BuildContext context,{required String id}) async {
    Alert.loading(context, Lang.get(context, key: LangKey.deleting));
    try{
      await local.deleteData(collectionName: 'exams', docId: id);


      Navigator.pop(context);
      // Navigator.pop(context);
      notifyListeners();
    }catch(e){
      Navigator.pop(context);

      Alert.msg(context, Lang.get(context, key: LangKey.error), e.toString());
    }
    }

}