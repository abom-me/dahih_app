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
        textTheme:TextTheme(
          /// all text style have this color 002055
          bodyLarge: TextStyle(color: const Color(0xff002055)),
          bodyMedium: TextStyle(color: const Color(0xff002055)),
          labelLarge: TextStyle(color: const Color(0xff002055)),
          bodySmall: TextStyle(color: const Color(0xff002055)),
          displayLarge: TextStyle(color: const Color(0xff002055)),
          displayMedium: TextStyle(color: const Color(0xff002055)),
          displaySmall: TextStyle(color: const Color(0xff002055)),
          headlineMedium: TextStyle(color: const Color(0xff002055)),
          headlineSmall: TextStyle(color: const Color(0xff002055)),
          titleLarge: TextStyle(color: const Color(0xff002055)),



        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Color(0xff002055)),

        ),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: "Noto Sana Arabic",useMaterial3: true, colorScheme: MaterialTheme.lightMediumContrastScheme().toColorScheme(),),
    darkTheme: ThemeData(fontFamily: "Noto Sana Arabic",useMaterial3: true, colorScheme: MaterialTheme.darkMediumContrastScheme().toColorScheme(),),
      home: const SplashPage(),
    );
  }
}

