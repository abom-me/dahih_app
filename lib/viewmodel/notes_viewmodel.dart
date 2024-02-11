

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khlfan_shtain/components/alerts.dart';
import 'package:khlfan_shtain/models/notes.dart';
import 'package:khlfan_shtain/viewmodel/local_storage_viewmodel.dart';

import '../auto_local/lang.dart';

final notesViewModelProvider = ChangeNotifierProvider<NotesViewModel>((ref) {
  return NotesViewModel();
});
class NotesViewModel with ChangeNotifier{
  LocalStorageViewModel local=LocalStorageViewModel();
  void addNote(BuildContext context,{required Notes data}){
    local.addData(collectionName: "notes", data: data.toJson(), docID: data.id!);
    notifyListeners();
  }
  StreamSubscription<Map<String, dynamic>>? _subscription;

 Future<List<Notes>> getNotes({required String filter}) async {
    Stream value= local.streamData(collectionName: 'notes');
    List<Notes> notes=[];
    value.listen((event) {

      notes.add(Notes.fromJson(event));
     if(filter !="all") notes.removeWhere((element) => element.tag!=filter);
      notifyListeners();
    });

    return notes;
  }

  addTag(BuildContext context,{required String tag}){
    local.addData(collectionName: "tags", data: {"tag":tag}, docID: tag);
    notifyListeners();
  }

 Future<List<String>> getTags() async {
   // Map value= local.getData(collectionName: 'tags');
   List<String> tags=[];
   tags.clear();
   final Map<String,dynamic>value=await local.getData(collectionName: 'tags');
   if(value['status'] != 'empty'){
     value.forEach((key, value) {
       tags.add(value['tag']);
     });
   }

    return tags;
  }


  deleteTag(BuildContext context,{required String tag}) async {
    await local.deleteData(collectionName: 'tags', docId: tag);
    notifyListeners();
    Alert.snackbar(context, text: Lang.get(context, key: LangKey.deleted));

  }

  deleteNote(BuildContext context,{required String id}) async {
    await local.deleteData(collectionName: 'notes', docId: id);
    notifyListeners();
    Alert.snackbar(context, text: Lang.get(context, key: LangKey.deleted));
  }
  
}