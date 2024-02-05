
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';




final promoTimerViewModelProvider = ChangeNotifierProvider<PromoTimerViewModel>((ref) {
  return PromoTimerViewModel();
});

class PromoTimerViewModel extends ChangeNotifier {
  int _minutes = 25;
  int _seconds = 0;
  bool isRunning = false;
   Timer _timer = Timer(Duration.zero, () {});

int get minutes => _minutes;
int get seconds => _seconds;

changeisRunning(){
  isRunning=!isRunning;


  notifyListeners();
}
void pushTimer() {
  _timer.cancel();
  notifyListeners();
}
  void startTimer() {
    print('start timer');
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {

        if (_minutes == 0 && _seconds == 0) {
          resetTimer();
        } else if (_seconds == 0) {
          _minutes--;
          _seconds = 59;
        } else {
          _seconds--;
        }
        notifyListeners();
      });

  }

  void resetTimer() {
    print('reset timer');
    _timer.cancel();

      isRunning = false;
      _minutes = 25;
      _seconds = 0;
    notifyListeners();
  }
}
