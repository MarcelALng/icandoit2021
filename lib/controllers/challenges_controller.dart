import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../models/challenge_model.dart';

class ChallengesController {
  List<ChallengeModel> _challengesList = [];

  List<ChallengeModel> getChallenges() {
    return _challengesList;
  }

  Future<List<ChallengeModel>> addChallenge(
      {@required String name,
      @required String target,
      @required String unity}) async {
    _challengesList.add(
      ChallengeModel(
        name: name,
        target: int.parse(target),
        unity: unity == "KG"
            ? unity_challenge.kg
            : unity_challenge.km, // ternary operator
      ),
    );
    final bool resultat = await _save(); // save data
    if (resultat) {
      print("ça marche");
    } else {
      print("ça bug $resultat");
    }
    return getChallenges();
  }

  Future<bool> _save() async {
    SharedPreferences localData = await SharedPreferences.getInstance();
    if (_challengesList.isNotEmpty) {
      List<String> _jsonList = _challengesList
          .map((challenge) => jsonEncode(challenge.toJSON()))
          .toList();
      print(_jsonList);
      return localData.setStringList("ChallengesList", _jsonList);
    }
    return false;
  }
}
