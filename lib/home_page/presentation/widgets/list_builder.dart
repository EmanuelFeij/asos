import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
  bool gettingData = false;
  bool isItDone = false;

  _getMoreData(States states) async {
    if (isItDone && states.paginationNotifier.value.offset != 0) {
      isItDone = false;
      return;
    }
    print("here");
    gettingData = true;
    final moreData =
        await widget.service.getLaunches(states.paginationNotifier.value);
    print("moredata ${moreData.length}");
    if (moreData.isEmpty) {
      if (states.paginationNotifier.value.offset == 0) {
        states.usersNotifier.value = <LaunchInfo>[];
      }
      isItDone = true;
      return;
    }
    if (states.paginationNotifier.value.offset == 0) {
      states.usersNotifier.value = moreData;
    } else {
      states.usersNotifier.value = [...states.usersNotifier.value, ...moreData];
    }
    gettingData = false;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print("didChangeDependencies");
    super.didChangeDependencies();
    final state = States.of(context)!;
    state.paginationNotifier.addListener(() {
      _getMoreData(state);
    });
    state.paginationNotifier.value = Pagination(
        limit: 20,
        offset: 0,
        sortOrder: SortOrder.asc,
        launchSuccessful: LaunchSuccessful.both,
        year: 0);
  }

  @override
  Widget build(BuildContext context) {
    final state = States.of(context)!;
    return ValueListenableBuilder(
        valueListenable: state.usersNotifier,
        builder: (BuildContext context, List<LaunchInfo> launchInfos,
            Widget? child) {
          return Expanded(
            child: ListView.builder(
                itemCount: launchInfos.length,
                itemBuilder: (context, index) {
                  if (index == launchInfos.length - 1) {
                    var pagination = state.paginationNotifier.value;
                    state.paginationNotifier.value = Pagination(
                      sortOrder: pagination.sortOrder,
                      year: pagination.year,
                      limit: pagination.limit,
                      launchSuccessful: pagination.launchSuccessful,
                      offset: pagination.offset + pagination.limit,
                    );
                  }
                  return GestureDetector(
                      onTap: () {
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext dialogContext) {
                            return Dialog(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      Navigator.of(context).pop();
                                      await launchUrl(
                                        Uri.parse(
                                            launchInfos[index].youtubeLink),
                                        mode: LaunchMode.externalApplication,
                                      );
                                    },
                                    // TODO: add to assets.
                                    child: Image.network(
                                      'https://1000logos.net/wp-content/uploads/2017/05/New-YouTube-logo.jpg',
                                      width: 75,
                                      height: 75,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      Navigator.of(context).pop();
                                      await launchUrl(
                                        Uri.parse(launchInfos[index].wikiLink),
                                        mode: LaunchMode.externalApplication,
                                      );
                                    },
                                    // TODO: add to assets.
                                    child: Image.network(
                                      'https://cdn.freebiesupply.com/images/large/2x/wikipedia-logo-transparent.png',
                                      width: 75,
                                      height: 75,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );

                        print(launchInfos[index].wikiLink);
                        print(launchInfos[index].flightNumber);
                        print(launchInfos[index].youtubeLink);
                      },
                      child: LaunchInfoWidget(launchInfo: launchInfos[index]));
                }),
          );
        });
  }
}
