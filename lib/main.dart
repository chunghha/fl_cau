import 'package:flutter/material.dart';

import 'package:fl_cau/pages/counter_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MobX',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const CounterPage(),
    );
  }
}
