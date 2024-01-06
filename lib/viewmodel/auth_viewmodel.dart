
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel  {

  final bool _isLogin = false;

 Future<bool> isLogin() async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   String? token = prefs.getString('token');
   if(token != null){
     return true;

  }else{
    return true;
  }
  }
}