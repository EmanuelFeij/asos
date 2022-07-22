import 'package:flutter/material.dart';
import 'package:spacex/home_page/domain/company_info.dart';

import '../../service/service.dart';
import '../widgets/ListBuilder.dart';
import '../widgets/black_bar_widget.dart';
import '../widgets/company_info_widget.dart';
import '../widgets/filter_dialog_widget.dart';

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
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                child: const Icon(
                  Icons.filter_alt,
                  color: Colors.black,
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const FilterDialogWidget();
                      });
                }),
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
