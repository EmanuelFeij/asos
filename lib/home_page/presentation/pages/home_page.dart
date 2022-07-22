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
  var limit = 20;
  var offset = 0;
  bool gettingData = false;
  bool isItDone = false;
  List<LaunchInfo> launchInfos = [];

  _getMoreData() async {
    gettingData = true;
    final moreData = await widget.service.getLaunches(
        Pagination(limit: limit, offset: offset, sortOrder: SortOrder.asc));
    if (moreData.isEmpty) {
      isItDone = true;
      gettingData = false;
      setState(() {});
      return;
    }
    offset += limit;
    setState(() {
      launchInfos = [...launchInfos, ...moreData];
    });
    gettingData = false;
  }

  @override
  void initState() {
    _getMoreData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: launchInfos.length,
          itemBuilder: (context, index) {
            if (index < launchInfos.length - 10) {
              return LaunchInfoWidget(launchInfo: launchInfos[index]);
            } else {
              if (!gettingData && !isItDone) {
                _getMoreData();
              }
            }
            if (!isItDone) {
              return const SizedBox(
                height: 80,
                child: Center(child: CircularProgressIndicator()),
              );
            }
            if (isItDone && index < launchInfos.length) {
              return LaunchInfoWidget(launchInfo: launchInfos[index]);
            }
            return const SizedBox();
          }),
    );
  }
}
