import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:spacex/home_page/domain/pagination.dart';

import '../service/repository.dart';

const String urlSpaceX = "api.spacexdata.com";

class RepositoryImpl implements Repository {
  @override
  Future<Map<String, dynamic>?> getCompanyInfo() async {
    var url = Uri.https(urlSpaceX, '/v3/info');

    var response = await http.get(url);

    return (response.statusCode == 200)
        ? convert.jsonDecode(response.body) as Map<String, dynamic>
        : null;
  }

  @override
  Future<List<dynamic>?> getLaunches(Pagination p) async {
    var args = {'limit': '${p.limit}', 'offset': '${p.offset}'};
    args['order'] = p.sortOrder == SortOrder.desc ? 'desc' : 'asc';
    if (p.launchSuccessful != LaunchSuccessful.both) {
      args['launch_success'] =
          p.launchSuccessful == LaunchSuccessful.yes ? 'true' : 'false';
    }
    if (p.year != 0) {
      args['launch_year'] = p.year.toString();
    }
    var url = Uri.https(urlSpaceX, '/v3/launches', args);
    var response = await http.get(url);

    return (response.statusCode == 200)
        ? convert.jsonDecode(response.body) as List<dynamic>
        : null;
  }
}
