import 'package:flutter/foundation.dart';
import 'dart:convert';

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
      ChallengeModel(name: name, target: int.parse(target), unity: unity),
    );
  }
}
