
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khlfan_shtain/utils/global_keys.dart';
import 'package:khlfan_shtain/viewmodel/local_storage_viewmodel.dart';

import '../models/user_model.dart';

final profileViewModelProvider = ChangeNotifierProvider<ProfileViewModel>((ref) {
  return ProfileViewModel();
});
class ProfileViewModel with ChangeNotifier{
LocalStorageViewModel local=LocalStorageViewModel();
  changeProfileImage(String profileImage) async {
   final newData= userData.toJson();
   newData.update("profileImage", (value) => profileImage);

   await  local.updateData(collectionName: "user", docId: userData.uid, data: newData);
   final Map<String,dynamic> user= await  local.getData(collectionName: "user");
   if(user['status'] != 'empty'){
     print(user);
     user.forEach((key, value) {
       userData= UserModel.fromJson(value);
     });
   notifyListeners();
  }
  }
}