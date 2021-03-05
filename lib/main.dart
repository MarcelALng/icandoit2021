import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/challenges_controller.dart';

import 'screens/home_screen.dart';

void main() => runApp(ICanDOIt());

class ICanDOIt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ICanDOIt',
      // ignore: missing_required_param
      home: ChangeNotifierProvider<ChallengesController>(
          // ignore: deprecated_member_use
          builder: (contex) => ChallengesController(),
          child: Home()),
    );
  }
}
