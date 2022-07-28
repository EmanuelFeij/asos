import 'package:flutter/material.dart';
import 'package:spacex/home_page/domain/lauch_info.dart';
import 'package:spacex/home_page/domain/pagination.dart';

import '../../service/service.dart';

class States extends InheritedWidget {
  States({
    Key? key,
    required this.child,
    required this.service,
  }) : super(key: key, child: child);

  final Service service;
  @override
  final Widget child;
  final usersNotifier = ValueNotifier(<LaunchInfo>[]);
  final darkThemeNotifier = ValueNotifier(true);
  final paginationNotifier = ValueNotifier<Pagination>(Pagination(
      limit: 10,
      offset: 0,
      sortOrder: SortOrder.asc,
      launchSuccessful: LaunchSuccessful.both,
      year: 0));

  static States? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<States>();
  }

  @override
  bool updateShouldNotify(States oldWidget) {
    return (darkThemeNotifier.value != oldWidget.darkThemeNotifier.value) ||
        (paginationNotifier.value.limit !=
                oldWidget.paginationNotifier.value.limit ||
            paginationNotifier.value.offset !=
                oldWidget.paginationNotifier.value.offset ||
            paginationNotifier.value.sortOrder !=
                oldWidget.paginationNotifier.value.sortOrder) ||
        usersNotifier.value != oldWidget.usersNotifier.value;
  }
}
