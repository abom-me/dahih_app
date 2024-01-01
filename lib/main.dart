import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khlfan_shtain/pages/splash.dart';
import 'package:khlfan_shtain/settings/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => {runApp(const ProviderScope(child: MyApp()))});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },

      title: 'Flutter Demo',

      theme: ThemeData(
        scaffoldBackgroundColor: Theme.of(context).colorScheme.background,
        fontFamily: "Noto Sana Arabic",useMaterial3: true, colorScheme: MaterialTheme.lightMediumContrastScheme().toColorScheme(),),
    darkTheme: ThemeData(fontFamily: "Noto Sana Arabic",useMaterial3: true, colorScheme: MaterialTheme.darkMediumContrastScheme().toColorScheme(),),
      home: const SplashPage(),
    );
  }
}

