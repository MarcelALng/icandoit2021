import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../models/challenge_model.dart';

const String keyAcces = "ChallengesList";

class ChallengesController {
  List<ChallengeModel> _challengesList = [];
  SharedPreferences _localData;

  List<ChallengeModel> getChallenges() {
    return _challengesList;
  }

  Future<List<ChallengeModel>> initChallengesList() async {
    _localData = await SharedPreferences.getInstance();
    final List<String> _tempList = _localData.getStringList(keyAcces);

    if (_tempList.isNotEmpty) {
      final List<dynamic> _jsonDecodeList = _tempList
          .map((challengeEncoded) => jsonDecode(challengeEncoded))
          .toList();

      _challengesList = _jsonDecodeList
          .map((challenge) => ChallengeModel.fromJSON(challenge))
          .toList();
      print(_challengesList);
    }
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
    if (_challengesList.isNotEmpty) {
      List<String> _jsonList = _challengesList
          .map((challenge) => jsonEncode(challenge.toJSON()))
          .toList();
      //print(_jsonList);
      return _localData.setStringList(keyAcces, _jsonList);
    }
    return false;
  }
}
