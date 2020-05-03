import 'dart:math';

import 'package:crowd_scout/widgets/MapPage.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  // TODO: Replace with an actual static userId that will not change when the app reloads
  final userId = Random().nextInt(1000000000);

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Crowd Scout',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: MapPage(title: 'Crowd Scout'),
      );
}
