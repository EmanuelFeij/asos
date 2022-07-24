import 'package:flutter/material.dart';

import '../../domain/lauch_info.dart';
import '../../domain/pagination.dart';
import '../../service/service.dart';
import 'launch_info_widget.dart';
import 'state_widget.dart';

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
    final state = States.of(context)!;
    gettingData = true;
    final moreData = await widget.service.getLaunches(state.paginationNotifier.value);
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
