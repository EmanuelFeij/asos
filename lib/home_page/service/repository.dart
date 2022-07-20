import '../domain/pagination.dart';

abstract class Repository {
  Future<List<dynamic>?> getLaunches(Pagination p);
  Future<Map<String, dynamic>?> getCompanyInfo();
}
