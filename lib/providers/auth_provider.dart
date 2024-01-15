
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khlfan_shtain/utils/enum/gender_enum.dart';

import '../viewmodel/auth_viewmodel.dart';

final authProvider = Provider<AuthProvider>((ref) {
  return AuthProvider(authViewModel: ref.read(authViewModelProvider));
});


class AuthProvider{
  final AuthViewModel authViewModel;
  AuthProvider({required this.authViewModel});

  Future register({required  BuildContext context,required GenderEnum gender,required String name}) async {
   await authViewModel.register(context: context,
        name: name,

     gender: gender
       );
  }

isLogin() async {
  return await authViewModel.isLogin();
}


}
