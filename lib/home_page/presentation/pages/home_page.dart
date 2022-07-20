import 'package:flutter/material.dart';
import 'package:spacex/home_page/domain/company_info.dart';
import 'package:spacex/home_page/domain/pagination.dart';
import 'package:spacex/home_page/presentation/widgets/launch_info_widget.dart';

import '../../domain/lauch_info.dart';
import '../../service/service.dart';
import '../widgets/black_bar_widget.dart';
import '../widgets/company_info_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.service}) : super(key: key);
  final Service service;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        centerTitle: true,
        title: const Text('SpaceX',
            style: TextStyle(
              color: Colors.black,
            )),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.filter_alt,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BlackBarTitle(text: "COMPANY"),
          buildCompanyFutureBuilder(),
          const BlackBarTitle(text: "LAUNCHES"),
          ListBuilder(
            service: widget.service,
          ),
        ],
      ),
    );
  }

  FutureBuilder<CompanyInfo> buildCompanyFutureBuilder() {
    return FutureBuilder(
      future: widget.service.getCompanyInfo(),
      builder: (BuildContext context, AsyncSnapshot<CompanyInfo> snapshot) {
        if (snapshot.hasData) {
          return CompanyInfoWidget(companyInfo: snapshot.data!);
        } else if (snapshot.hasError) {
          print(snapshot.error);
        }
        return const Center(child: Text("LOADING"));
      },
    );
  }
}

class ListBuilder extends StatefulWidget {
  const ListBuilder({
    Key? key,
    required this.service,
  }) : super(key: key);

  final Service service;

  @override
  State<ListBuilder> createState() => _ListBuilderState();
}

class _ListBuilderState extends State<ListBuilder> {
  var limit = 15;
  var offset = 0;
  List<LaunchInfo> launchInfos = [];

  _getMoreData() async {
    print('getMoreData');
    final moreData = await widget.service.getLaunches(
        Pagination(limit: limit, offset: offset, sortOrder: SortOrder.asc));
    offset += limit;
    setState(() {
      launchInfos = [...launchInfos, ...moreData];
    });
  }

  @override
  void initState() {
    print('Caralho');
    _getMoreData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('rebuilding lis');
    return Expanded(
      child: ListView.builder(
        itemCount: launchInfos.length,
        itemBuilder: (context, index) {
          print('$index  ${launchInfos.length}');
          if (index < launchInfos.length - 5) {
            return LaunchInfoWidget(launchInfo: launchInfos[index]);
          } else {
            print('foscasse');
            _getMoreData();
            return const SizedBox(
              height: 80,
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}
