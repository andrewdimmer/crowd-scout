import 'package:crowd_scout/widgets/MapPage.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Crowd Scout',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: MapPage(title: 'Crowd Scout'),
      );
}
