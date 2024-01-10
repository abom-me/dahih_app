import 'package:flutter/material.dart';
import 'package:flutter_locales2/flutter_locales2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
final settingsViewModelProvider = ChangeNotifierProvider.autoDispose<SettingsViewModel>((ref) {
  return SettingsViewModel();
});
class SettingsViewModel extends ChangeNotifier {
  ThemeMode theme=  ThemeMode.light;
  final pref=  SharedPreferences.getInstance();
  ThemeMode getThemeMode() {
    notifyListeners();
    return theme;
  }
  changeTheme(bool light) async {
   final save= await pref;
   save.setBool("theme", light?true:false);
    theme = light ? ThemeMode.light : ThemeMode.dark;

    notifyListeners();
  }
  getTheme() async {
    final save= await pref;
    if(save.containsKey("theme")){
      theme=save.getBool("theme")! ?ThemeMode.light:ThemeMode.dark;

    }
    notifyListeners();
  }


  changeLang(BuildContext context,String lang) {
    notifyListeners();
    Locales.change(context, lang);
  }


}
