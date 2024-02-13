

import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';

class LocalStorageViewModel extends ChangeNotifier {
  final db = Localstore.instance;

  addData({required String collectionName,required Map<String,dynamic> data,required String docID}) async {
    final id = db.collection(collectionName).doc().id;

    await db.collection(collectionName).doc(docID).set(data);

  }

  updateData({required String collectionName,required String docId,required Map<String,dynamic> data}) async {
    await db.collection(collectionName).doc(docId).set(data);

  }

  deleteData({required String collectionName,required String docId}) async {
    await db.collection(collectionName).doc(docId).delete();

  }

  getData({required String collectionName}) async {
final data = await db.collection(collectionName).get();

if(data != null){
  return data;
}else{
  return {"status":"empty"};
}


  }

 Stream streamData({required String collectionName})  {
 return  db.collection(collectionName).stream;


  }



}
