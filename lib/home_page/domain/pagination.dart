class Pagination {
  final int limit;
  final int offset;
  final SortOrder sortOrder;
  final LaunchSuccessful launchSuccessful;
  final int year;

  Pagination(
      {required this.launchSuccessful,
      required this.year,
      required this.limit,
      required this.offset,
      required this.sortOrder});
}

enum SortOrder { asc, desc }

enum LaunchSuccessful { yes, no, both }
