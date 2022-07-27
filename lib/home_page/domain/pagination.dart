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

extension SortOrderString on SortOrder {
  String toShortString() {
    return toString().split('.').last.toUpperCase();
  }
}

enum LaunchSuccessful { yes, no, both }

extension LaunchSuccessfulString on LaunchSuccessful {
  String toShortString() {
    return toString().split('.').last.toUpperCase();
  }
}
