import '../domain/company_info.dart';
import '../domain/lauch_info.dart';
import '../domain/pagination.dart';
import 'repository.dart';

class Service {
  final Repository repo;

  Service({required this.repo});

  Future<CompanyInfo> getCompanyInfo() async {
    print("cenas");
    var json = await repo.getCompanyInfo();
    if (json == null) {
      throw Error();
    }
    return CompanyInfo.fromJson(json);
  }

  Future<List<LaunchInfo>> getLaunches(Pagination p) async {
    var json = await repo.getLaunches(p);
    if (json == null) {
      throw Error();
    }

    return json
        .map((m) => LaunchInfo.fromJson(m as Map<String, dynamic>))
        .toList();
  }
}
