import 'package:flutter/material.dart';
import 'package:spacex/home_page/domain/pagination.dart';

import '../../service/service.dart';

class States extends InheritedWidget {
  States({
    Key? key,
    required this.child,
    required this.service,
  }) : super(key: key, child: child);

  final Service service;
  final Widget child;
  final darkThemeNotifier = ValueNotifier(true);
  final paginationNotifier =
      ValueNotifier(Pagination(limit: 20, offset: 0, sortOrder: SortOrder.asc));

  static States? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<States>();
  }

  @override
  bool updateShouldNotify(States oldWidget) {
    return darkThemeNotifier.value != oldWidget.darkThemeNotifier.value ||
        (paginationNotifier.value.limit !=
                oldWidget.paginationNotifier.value.limit ||
            paginationNotifier.value.offset !=
                oldWidget.paginationNotifier.value.offset ||
            paginationNotifier.value.sortOrder !=
                oldWidget.paginationNotifier.value.sortOrder);
  }
}
