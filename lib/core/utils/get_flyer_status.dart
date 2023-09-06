String getFlyerStatus(DateTime endDate) {
  int day = endDate.day;
  int month = endDate.month;
  String status = "ساري حتي ";
  DateTime current = DateTime.now();
  int weekDay = endDate.weekday;
  if (current.year > endDate.year) return status = "انتهي العرض";
  if (current.month > month) return status = "انتهي العرض";
  if (current.month == month && current.day > day) {
    return status = "انتهي العرض";
  }
  if (current.month == month && current.day == day) {
    return status = "ساري حتي نهاية اليوم";
  }
  if (current.month == month) {
    if ((day - current.day) < 7) {
      if (current.weekday == 4 || current.weekday == 5) {
        if (weekDay == 6 || weekDay == 7) {
          return status += "بداية الاسبوع القادم";
        }
        if (weekDay == 4 || weekDay == 5) {
          if ((day - current.day) > 1) {
            return status += "نهاية الاسبوع القادم";
          }
          else {
            return status += "نهاية الاسبوع";
          }
        }
        if (weekDay == 1 || weekDay == 2 || weekDay == 3) {
          return status += "منتصف الاسبوع القادم";
        }
      } else if (current.weekday == 1 ||
          current.weekday == 2 ||
          current.weekday == 3) {
        if (weekDay == 6 || weekDay == 7) {
          return status += "بداية الاسبوع القادم";
        }
        if (weekDay == 4 || weekDay == 5) return status += "نهاية الاسبوع";
        if (weekDay == 1 || weekDay == 2 || weekDay == 3) {
          if ((day - current.day) > 1) {
            return status += "منتصف الاسبوع القادم";
          }
          else {
            return status += "منتصف الاسبوع";
          }
        }
      } else if (current.weekday == 6 || current.weekday == 7) {
        if (weekDay == 6 || weekDay == 7) {
          if ((day - current.day) > 1) {
            return status += "بداية الاسبوع القادم";
          }
          else {
            return status += "بداية الاسبوع";
          }
        }
        if (weekDay == 4 || weekDay == 5) return status += "نهاية الاسبوع";
        if (weekDay == 1 || weekDay == 2 || weekDay == 3) {
          return status += "منتصف الاسبوع";
        }
      }
    }
    if (day >= 20) return status += "نهاية الشهر";
    if (day <= 10) return status += "بداية الشهر";
    if (day <= 20 && day >= 10) return status += "منتصف الشهر";
  } else if (month == current.month + 1) {
    if (day >= 20) return status += "نهاية الشهر القادم";
    if (day <= 10) return status += "بداية الشهر القادم";
    if (day <= 20 && day >= 10) return status += "منتصف الشهر القادم";
  } else {
    return status = "العرض مستمر";
  }
  return status;
}
