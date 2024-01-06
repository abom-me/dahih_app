

import 'enum/days_enum.dart';

extension convertDayToArabic on String {
 String get dayToArabic{
   switch (this){
     case "Sunday":
       return "الأحد";
      case "Monday":
        return "الأثنين";
      case "Tuesday":
        return "الثلاثاء";
      case "Wednesday":
        return "الأربعاء";
      case "Thursday":
        return "الخميس";
      case "Friday":
        return "الجمعة";
      case "Saturday":
        return "السبت";
      default:
        return "الأحد";

   }
 }
}