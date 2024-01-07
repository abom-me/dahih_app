

extension ConvertMonths on String{
  String get toArabicMonth {
    switch (this) {
      case "January":
        return "يناير";
      case "February":
        return "فبراير";
      case "March":
        return "مارس";
      case "April":
        return "أبريل";
      case "May":
        return "مايو";
      case "June":
        return "يونيو";
      case "July":
        return "يوليو";
      case "August":
        return "أغسطس";
      case "September":
        return "سبتمبر";
      case "October":
        return "أكتوبر";
      case "November":
        return "نوفمبر";
      case "December":
        return "ديسمبر";
      default:
        return "يناير";
    }
  }
}