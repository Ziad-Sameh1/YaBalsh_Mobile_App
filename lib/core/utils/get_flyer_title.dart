String getFlyerTitle(DateTime startDate) {
  return "${startDate.day} ${_getMonthName(startDate)} ";
}

String _getMonthName(DateTime date) {
  int month = date.month;
  switch (month) {
    case 1:
      return "يناير";
    case 2:
      return "فبراير";
    case 3:
      return "مارس";
    case 4:
      return "ابريل";
    case 5:
      return "مايو";
    case 6:
      return "يونيو";
    case 7:
      return "يوليو";
    case 8:
      return "اغسطس";
    case 9:
      return "سبتمبر";
    case 10:
      return "اكتوبر";
    case 11:
      return "نوفمبر";
    case 12:
      return "ديسمبر";
    default:
      return "";
  }
}
