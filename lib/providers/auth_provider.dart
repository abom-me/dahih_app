
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewmodel/auth_viewmodel.dart';

final authProvider = Provider<AuthProvider>((ref) {
  return AuthProvider(authViewModel: ref.read(authViewModelProvider));
});


class AuthProvider{
  final AuthViewModel authViewModel;
  AuthProvider({required this.authViewModel});

  Future register({required  BuildContext context,required String email,required String password,required String name}) async {
   await authViewModel.register(context: context,
        name: name,
        email: email,
        password: password,
       );
  }

  Future<bool> isLogin() async {
    return await authViewModel.isLogin();
  }

  login({required BuildContext context,required String email,required String password}) async {
    await authViewModel.login(context: context, email: email, password: password);
  }
}
