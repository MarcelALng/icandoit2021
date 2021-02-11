import 'package:flutter/foundation.dart';

enum unity_challenge { kg, km }

class ChallengeModel {
  final String name;
  final int target;
  final unity_challenge unity;

  ChallengeModel({
    @required this.name,
    @required this.target,
    @required this.unity,
  });

  ChallengeModel.fromJSON(Map<String, dynamic> json)
      : name = json['name'],
        target = json['target'],
        unity = json['unity'];

  Map<String, dynamic> toJSON() {
    return {"name": name, "target": target, "unity": unity.toString()};
  }
}
