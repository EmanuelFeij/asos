import 'package:flutter/material.dart';

import 'home_page/data/repository.dart';
import 'home_page/presentation/pages/home_page.dart';
import 'home_page/service/service.dart';

void main() {
  RepositoryImpl repo = RepositoryImpl();
  Service service = Service(repo: repo);

  runApp(MyApp(service: service));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.service}) : super(key: key);
  final Service service;
  // This widget is the root of your service.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(
        service: service,
      ),
    );
  }
}
