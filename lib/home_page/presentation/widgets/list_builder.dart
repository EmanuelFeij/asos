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
  late ScrollController _scrollController;

  bool gettingData = false;
  bool isItDone = false;

  _getMoreData(States states) async {
    if (states.paginationNotifier.value.offset == 0) {
      _scrollToTop();
    }

    if (isItDone && states.paginationNotifier.value.offset != 0) {
      isItDone = false;
      return;
    }
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
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
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

  void _scrollToTop() {
    print("scrool me");
    _scrollController
      ..animateTo(0,
          duration: const Duration(seconds: 1), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    final state = States.of(context)!;

    return ValueListenableBuilder(
        valueListenable: state.usersNotifier,
        builder: (BuildContext context, List<LaunchInfo> launchInfos,
            Widget? child) {
          if (launchInfos.isEmpty) {
            return const Center(child: Text("No launch info available"));
          }
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  controller: _scrollController,
                  itemCount: launchInfos.length,
                  itemBuilder: (context, index) {
                    if (index == launchInfos.length - 10 && !gettingData) {
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
                                      child: const Image(
                                        image: AssetImage(
                                            'assets/youtube_logo.jpg'),
                                        width: 85,
                                        height: 85,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        Navigator.of(context).pop();
                                        await launchUrl(
                                          Uri.parse(
                                              launchInfos[index].wikiLink),
                                          mode: LaunchMode.externalApplication,
                                        );
                                      },
                                      child: const Image(
                                        image: AssetImage(
                                            "assets/wikipedia_logo.png"),
                                        width: 85,
                                        height: 85,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(16),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              border: Border.all(),
                              shape: BoxShape.rectangle,
                              borderRadius: const BorderRadius.all(
                                  Radius.elliptical(10, 10))),
                          child:
                              LaunchInfoWidget(launchInfo: launchInfos[index]),
                        ));
                  }),
            ),
          );
        });
  }
}
