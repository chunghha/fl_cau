import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:fl_cau/pages/counter_page.dart';
import 'package:fl_cau/pages/news_page.dart';
import 'package:fl_cau/store/counter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MobX State Management',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Provider<Counter>(
        create: (_) => Counter(),
        child: CounterPage(),
      ),
      routes: {
        '/news': (_) => NewsPage(),
      },
    );
  }
}
