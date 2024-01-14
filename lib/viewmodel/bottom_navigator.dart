

import 'package:flutter/material.dart';
import 'package:khlfan_shtain/pages/home/home.dart';
import 'package:khlfan_shtain/utils/enum/screens_enum.dart';

import '../pages/tasks/tasks.dart';

class BottomNavigatorViewModel extends ChangeNotifier {
  ScreensEnum _currentIndex = ScreensEnum.home;
  ScreensEnum get currentIndex => _currentIndex;

  void changeIndex(ScreensEnum screen) {
    _currentIndex = screen;
    notifyListeners();
  }

  Widget showScreen() {

    switch (currentIndex) {
      case ScreensEnum.home:
        return const HomePage();
      case ScreensEnum.profile:
        return const Center(
          child: Text(
            "الرسائل",
            style: TextStyle(fontSize: 30),
          ),
        );
        case ScreensEnum.tasks:
        return const TasksScreen();

      default:
        return const Center(
          child: Text(
            "الرئيسية",
            style: TextStyle(fontSize: 30),
          ),
        );
    }

  }
}
