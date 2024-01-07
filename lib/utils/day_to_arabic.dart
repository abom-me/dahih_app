

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

 String get shortDayToArabic{
   switch (this){
     case "Sun":
       return "الأحد";
      case "Mon":
        return "الأثنين";
      case "Tue":
        return "الثلاثاء";
      case "Wed":
        return "الأربعاء";
      case "Thu":
        return "الخميس";
      case "Fri":
        return "الجمعة";
      case "Sat":
        return "السبت";
      default:
        return "الأحد";


   }
 }
}