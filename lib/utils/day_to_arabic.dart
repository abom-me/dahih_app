

import 'package:khlfan_shtain/auto_local/lang.dart';


extension convertDayToArabic on String {
 LangKey get dayToLangKey{
   switch (this){
     case "Sunday":
       return LangKey.sunday;
      case "Monday":
        return LangKey.monday;
      case "Tuesday":
        return LangKey.tuesday;
      case "Wednesday":
        return  LangKey.wednesday;
      case "Thursday":
        return LangKey.thursday;
      case "Friday":
        return LangKey.friday;
      case "Saturday":
        return LangKey.saturday;
      default:
        return LangKey.sunday;

   }
 }

 LangKey get shortDayToLangKey{
   switch (this){
     case "Sun":
       return LangKey.sun;
      case "Mon":
        return LangKey.mon;
      case "Tue":
        return LangKey.tue;
      case "Wed":
        return LangKey.wed;
      case "Thur":
        return LangKey.thu;
      case "Fri":
        return LangKey.fri;
      case "Sat":
        return LangKey.sat;
      default:
        print(this);
        return LangKey.sun;


   }
 }
}