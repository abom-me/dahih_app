
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khlfan_shtain/utils/check_arabic_text.dart';

class TextFieldViewModel extends StateNotifier<dynamic>  {
  TextFieldViewModel(super.state);


   changeTextDirection(String value){


state= value.isArabic?TextDirection.rtl:TextDirection.ltr;

  }
  bool obscureTextValue = true;
  obscureText() {
    obscureTextValue = !obscureTextValue;

  }






}