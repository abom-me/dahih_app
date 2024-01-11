
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khlfan_shtain/components/alerts.dart';
import 'package:khlfan_shtain/models/user_model.dart';
import 'package:khlfan_shtain/settings/routes.dart';
import 'package:khlfan_shtain/utils/enum/firebase_auth_errors.dart';

import '../pages/nav.dart';
import '../utils/global_keys.dart';

final authViewModelProvider= Provider<AuthViewModel>((ref) => AuthViewModel());
class AuthViewModel  {
final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final bool _isLogin = false;

 Future<bool> isLogin() async {
   String? token = _auth.currentUser?.uid;
   if(token != null){
    final data=await _firestore.collection('users').doc(token).get();
    Map<String,dynamic>user =  data.data()!;
userData=UserModel.fromJson(user);
     return true;

  }else{
    return false;
  }
  }


  Future register({
    required BuildContext context ,
    required String name,
    required String email,
    required String password,


  }) async {
   Alert.loading(context, "يتم فتح حساب الان");
   try{

     UserCredential user=await _auth.createUserWithEmailAndPassword(email: email, password: password);
String uid=user.user!.uid;
await FirebaseFirestore.instance.collection('users').doc(uid).set({
  "uid":uid,
  "name":name,
  "email":email
});
Navigator.pop(context);
GoPage.pushF(page: const BottomNavigator(), context: context);

   } on FirebaseAuthException catch (e){
     Navigator.pop(context);
print(e.code);
     Alert.msg(context, "خطأ", FirebaseAuthError.create(e.code));
   }catch(e){
     Navigator.pop(context);

     Alert.msg(context, "خطأ", e.toString());
   }
  }


  login({required BuildContext context,required String email,required String password}) async {
    Alert.loading(context, "يتم تسجيل الدخول");
    try{
      UserCredential user=await _auth.signInWithEmailAndPassword(email: email, password: password);
      String uid=user.user!.uid;
      final data=await _firestore.collection('users').doc(uid).get();
      Map<String,dynamic>userMap =  data.data()!;
      userData=UserModel.fromJson(userMap);
      Navigator.pop(context);
      GoPage.pushF(page: const BottomNavigator(), context: context);

    } on FirebaseAuthException catch (e){
      Navigator.pop(context);
      print(e.code);
      Alert.msg(context, "خطأ", FirebaseAuthError.login(e.code));
    }catch(e){
      Navigator.pop(context);

      Alert.msg(context, "خطأ", e.toString());
    }
  }
}