import 'package:flutter/material.dart';
import 'package:spacex/theme/color_schemes.g.dart';

import 'home_page/data/repository.dart';
import 'home_page/presentation/pages/home_page.dart';
import 'home_page/presentation/widgets/state_widget.dart';
import 'home_page/service/service.dart';

void main() {
  RepositoryImpl repo = RepositoryImpl();
  Service service = Service(repo: repo);

  runApp(States(child: const MyApp(), service: service));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your service.
  @override
  Widget build(BuildContext context) {
    final state = States.of(context)!.darkThemeNotifier;
    return ValueListenableBuilder(
      valueListenable: state,
      builder: ((context, bool value, child) {
        return MaterialApp(
          theme: value ? lightThemeData : darkThemeData,
          title: 'Flutter Demo',
          home: const HomePage(),
        );
      }),
    );
  }
}
