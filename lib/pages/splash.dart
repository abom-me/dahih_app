import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:home_widget/home_widget.dart';
import 'package:khlfan_shtain/pages/nav.dart';
import 'package:khlfan_shtain/settings/routes.dart';
import 'package:khlfan_shtain/viewmodel/settings_viewmodel.dart';

import '../auto_local/lang.dart';
import '../providers/auth_provider.dart';
import 'auth/register.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
getData() async {
  ref.read(settingsViewModelProvider.notifier).getTheme();
  final auth = ref.watch(authProvider);
if(await auth.isLogin()){
GoPage.pushF(page: const BottomNavigator(), context: context);
}else{
GoPage.pushF(page: const RegisterPage(), context: context);
}
}
@pragma("vm:entry-point")
Future<void> interactiveCallback(Uri? data) async {
  if (data?.host == 'titleclicked') {
    final greetings = [
      'Hello',
      'Hallo',
      'Bonjour',
      'Hola',
      'Ciao',
      '哈洛',
      '안녕하세요',
      'xin chào',
    ];
    final selectedGreeting = greetings[Random().nextInt(greetings.length)];
    // await HomeWidget.setAppGroupId('group.com.abom.daheh');
    // await HomeWidget.saveWidgetData<String>('title', selectedGreeting);
    // await HomeWidget.updateWidget(
    //   name: 'HomeWidgetExampleProvider',
    //   iOSName: 'daheh_widget',
    // );
  }
}

@override
  void initState() {
  // HomeWidget.setAppGroupId('group.com.abom.daheh');
  // HomeWidget.registerInteractivityCallback(interactiveCallback);
  // TODO: implement initState
    super.initState();
 Timer(const Duration(seconds: 3), () {
   getData();
  });
  }
  @override
  Widget build(BuildContext context) {
    // final auth = ref.watch(authProvider);
    return Scaffold(
      body: Center(
        child: Text(
          Lang.get(context, key: LangKey.appS),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
