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
          // TODO: all width
          const BlackBarTitle(text: "COMPANY"),
          buildCompanyFutureBuilder(),
          const BlackBarTitle(text: "LAUNCHES"),
          buildLaunchesFutureBuilder()
        ],
      ),
    );
  }

  FutureBuilder<List<LaunchInfo>> buildLaunchesFutureBuilder() {
    return FutureBuilder(
        future: widget.service.getLaunches(
            Pagination(limit: 10, offset: 0, sortOrder: SortOrder.asc)),
        builder:
            (BuildContext context, AsyncSnapshot<List<LaunchInfo>> snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            var data = snapshot.data != null ? snapshot.data! : [];
            print(data);
            return Expanded(
              child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    print(snapshot.data);
                    return LaunchInfoWidget(launchInfo: data[index]);
                  }),
            );
          } else if (snapshot.hasError) {
            print(snapshot.error);
          }
          return const Center(child: Text("LOADING"));
        });
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
