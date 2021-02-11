import 'package:flutter/foundation.dart';

enum unity_challenge { kg, km }

class ChallengeModel {
  String name;
  int target;
  unity_challenge unity;

  ChallengeModel({
    @required this.name,
    @required this.target,
    @required this.unity,
  });

  Map<String, dynamic> maMap = {"banane": "jaune"};
}
