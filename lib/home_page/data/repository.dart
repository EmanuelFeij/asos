import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:spacex/home_page/domain/pagination.dart';

import '../service/repository.dart';

String URL = "api.spacexdata.com";

class RepositoryImpl implements Repository {
  @override
  Future<Map<String, dynamic>?> getCompanyInfo() async {
    var url = Uri.https(URL, '/v3/info');

    var response = await http.get(url);

    return (response.statusCode == 200)
        ? convert.jsonDecode(response.body) as Map<String, dynamic>
        : null;
  }

  @override
  Future<List<dynamic>?> getLaunches(Pagination p) async {
    var url = Uri.https(
        URL, '/v3/launches', {'limit': '${p.limit}', 'offset': '${p.offset}'});

    var response = await http.get(url);

    return (response.statusCode == 200)
        ? convert.jsonDecode(response.body) as List<dynamic>
        : null;
  }
}
