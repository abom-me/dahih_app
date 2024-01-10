import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_locales2/flutter_locales2.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khlfan_shtain/pages/splash.dart';
import 'package:khlfan_shtain/settings/theme.dart';
import 'package:khlfan_shtain/viewmodel/settings_viewmodel.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Locales.init(['ar','en']);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 await  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => {runApp(const ProviderScope(child: MyApp()))});
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
ref.read(settingsViewModelProvider).getTheme();
    return LocaleBuilder(builder: (locale){
      return MaterialApp(
        locale: locale,
        localizationsDelegates:Locales.delegates,
        supportedLocales: Locales.supportedLocales,
        // builder: (context, child) {
        //   return Directionality(
        //     // textDirection: TextDirection.rtl,
        //     textDirection: null,
        //     child: child!,
        //   );
        // },

        title: 'Flutter Demo',

        themeMode: ref.watch(settingsViewModelProvider).theme,
        theme: ThemeData(
          textTheme:const TextTheme(
            /// all text style have this color 002055
            // bodyLarge: TextStyle(color: Color(0xff002055)),
            // bodyMedium: TextStyle(color: Color(0xff002055)),
            // labelLarge: TextStyle(color: Color(0xff002055)),
            // bodySmall: TextStyle(color: Color(0xff002055)),
            // displayLarge: TextStyle(color: Color(0xff002055)),
            // displayMedium: TextStyle(color: Color(0xff002055)),
            // displaySmall: TextStyle(color: Color(0xff002055)),
            // headlineMedium: TextStyle(color: Color(0xff002055)),
            // headlineSmall: TextStyle(color: Color(0xff002055)),
            // titleLarge: TextStyle(color: Color(0xff002055)),



          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: Color(0xff002055)),

          ),
          scaffoldBackgroundColor: Colors.white,
          fontFamily: "IBM Plex Sans Arabic",useMaterial3: true, colorScheme: MaterialTheme.lightMediumContrastScheme().toColorScheme(),),
        darkTheme: ThemeData(fontFamily: "IBM Plex Sans Arabic",useMaterial3: true, colorScheme: MaterialTheme.darkMediumContrastScheme().toColorScheme(),),
        home: const SplashPage(),
      );
    });
  }
}

