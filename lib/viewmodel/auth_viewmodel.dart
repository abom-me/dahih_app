
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel  {
final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final bool _isLogin = false;

 Future<bool> isLogin() async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   String? token = prefs.getString('token');
   if(token != null){
     return true;

  }else{
    return false;
  }
  }


  Future register() async {

  }
}