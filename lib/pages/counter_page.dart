import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:fl_cau/store/counter.dart';

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<Counter>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MobX Counter',
          style: GoogleFonts.caveat(
            textStyle: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        actions: <Widget>[
          IconButton(
            color: Colors.tealAccent,
            icon: Icon(Icons.navigate_next),
            iconSize: 36.0,
            onPressed: () {
              Navigator.pushNamed(context, '/news');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Counter Number in the state:',
              style: GoogleFonts.googleSans(fontSize: 24.0),
            ),
            // Wrapping in the Observer will automatically re-render on changes to counter.value
            Observer(
              builder: (_) => Text(
                '${counter.value}',
                style: GoogleFonts.monoton(
                    textStyle: Theme.of(context).textTheme.display1),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.teal[50],
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              color: Colors.red[700],
              onPressed: counter.decrement,
              icon: Icon(Icons.remove),
              iconSize: 36.0,
            ),
            IconButton(
              color: Colors.indigo[700],
              onPressed: counter.increment,
              icon: Icon(Icons.add),
              iconSize: 36.0,
            ),
          ],
        ),
      ),
    );
  }
}
