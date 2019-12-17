import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'package:fl_cau/pages/counter_page.dart';
import 'package:fl_cau/pages/news_page.dart';
import 'package:fl_cau/store/counter.dart';
import 'package:fl_cau/store/hacker_news.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<Counter>(
            create: (_) => Counter(),
          ),
          Provider<HackerNews>(
            create: (_) => HackerNews(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MobX State Management',
          theme: ThemeData(
            primarySwatch: Colors.teal,
          ),
          home: Consumer<Counter>(builder: (context, counter, _) {
            return CounterPage();
          }),
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/news':
                return PageTransition(
                    child: NewsPage(),
                    duration: Duration(milliseconds: 500),
                    type: PageTransitionType.rightToLeftWithFade);
                break;
              default:
                return null;
            }
          },
        ));
  }
}
