

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
final newSheetProvider = ChangeNotifierProvider<NewSheetProvider>((ref) {
  return NewSheetProvider();
});
class NewSheetProvider extends ChangeNotifier {
bool start = false;
   startb(){
    start = true;
    notifyListeners();


  }
}
