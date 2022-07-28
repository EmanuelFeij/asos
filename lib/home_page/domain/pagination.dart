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

extension Capitalize on String {
  String capitalize() {
    if (isEmpty) {
      return this;
    }

    return this[0].toUpperCase() + substring(1);
  }
}

extension SortOrderString on SortOrder {
  String toShortString() {
    return toString().split('.').last.capitalize();
  }
}

enum LaunchSuccessful { yes, no, both }

extension LaunchSuccessfulString on LaunchSuccessful {
  String toShortString() {
    return toString().split('.').last.capitalize();
  }
}
