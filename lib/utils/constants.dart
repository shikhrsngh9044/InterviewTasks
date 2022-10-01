enum SortType {
  byName,
  byPrice,
  byDate,
}

extension DaysX on DateTime {
  String get getFormattedDateString => "$day/$month/$year";
}
