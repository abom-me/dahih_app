import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khlfan_shtain/pages/nav.dart';
import 'package:khlfan_shtain/settings/routes.dart';

import '../providers/auth_provider.dart';
import 'home/home.dart';
import 'login.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
getData() async {
  final auth = ref.watch(authProvider);
if(await auth.isLogin()){
GoPage.pushF(page: BottomNavigator(), context: context);
}else{
GoPage.pushF(page: LoginPage(), context: context);
}
}
@override
  void initState() {
    // TODO: implement initState
    super.initState();
 Timer(Duration(seconds: 3), () {
   getData();
  });
  }
  @override
  Widget build(BuildContext context) {
    // final auth = ref.watch(authProvider);
    return Scaffold(
      body: Center(
        child: Text(
          "سبلاش سكرين",
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
    );
  }
}
