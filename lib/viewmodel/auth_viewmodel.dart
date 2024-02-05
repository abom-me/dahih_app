import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khlfan_shtain/components/alerts.dart';
import 'package:khlfan_shtain/models/user_model.dart';
import 'package:khlfan_shtain/settings/routes.dart';
import 'package:khlfan_shtain/utils/enum/gender_enum.dart';
import 'package:uuid/uuid.dart';

import '../auto_local/lang.dart';
import '../pages/nav.dart';
import '../utils/global_keys.dart';
import 'local_storage_viewmodel.dart';

final authViewModelProvider= Provider<AuthViewModel>((ref) => AuthViewModel());
class AuthViewModel  {

LocalStorageViewModel local=LocalStorageViewModel();

  Future register({
    required BuildContext context ,
    required String name,
    required GenderEnum gender,


  }) async {
    Alert.loading( context, Lang.get(context, key: LangKey.saving));
String id=const Uuid().v1();
UserModel user=UserModel(uid: id, name: name, gender: gender.gender,profileImage:gender==GenderEnum.male?"i5.png":"i43.png" );
   await local.addData(collectionName: "user", data: user.toJson(), docID: id);
   userData=user;
   Navigator.pop(context);
    GoPage.pushF(page: const BottomNavigator(), context: context);
  }

isLogin() async {
  final Map<String,dynamic> user= await  local.getData(collectionName: "user");
  if(user['status'] != 'empty'){
print(user);
  user.forEach((key, value) {
    userData= UserModel.fromJson(value);
  });
    return true;
}else{
    return false;
  }
}
}
