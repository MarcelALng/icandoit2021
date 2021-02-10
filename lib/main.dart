import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() => runApp(ICanDOIt());

class ICanDOIt extends StatelessWidget {
  @override
  Widget build(BuildContext) {
    return MaterialApp(
      title: 'ICanDOIt',
      home: Home(),
    );
  }
}
