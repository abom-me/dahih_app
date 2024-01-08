

import 'package:khlfan_shtain/auto_local/lang.dart';

extension ConvertMonths on String{
  LangKey get toMonthLangKey {
    switch (this) {
      case "January":
        return LangKey.january;
      case "February":
        return LangKey.february;
      case "March":
        return LangKey.march;
      case "April":
        return  LangKey.april;
      case "May":
        return LangKey.may;
      case "June":
        return LangKey.june;
      case "July":
        return LangKey.july;
      case "August":
        return LangKey.august;
      case "September":
        return LangKey.september;
      case "October":
        return LangKey.october;
      case "November":
        return LangKey.november;
      case "December":
        return LangKey.december;
      default:
        return  LangKey.january;
    }
  }
}