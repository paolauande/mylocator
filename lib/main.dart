import 'package:flutter/material.dart';
import 'package:mylocator/screens/Address.dart';
import 'package:mylocator/widgets/styles.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Locator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: defaultColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Address(),
    );
  }
}
