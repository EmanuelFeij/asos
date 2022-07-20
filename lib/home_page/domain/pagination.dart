class Pagination {
  final int limit;
  final int offset;
  final SortOrder sortOrder;

  Pagination(
      {required this.limit, required this.offset, required this.sortOrder});
}

enum SortOrder { asc, desc }
