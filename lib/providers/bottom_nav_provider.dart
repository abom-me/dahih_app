
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khlfan_shtain/viewmodel/bottom_navigator.dart';

final bottomNavProvider = ChangeNotifierProvider<BottomNavigatorViewModel>((ref) {
  return BottomNavigatorViewModel();
});