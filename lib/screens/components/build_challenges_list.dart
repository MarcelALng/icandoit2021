import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../models/challenge_model.dart';

import 'package:icandoit2021/controllers/challenges_controller.dart';

class ChallengeListBuilder extends StatefulWidget {
  @override
  _ChallengeListBuilderState createState() => _ChallengeListBuilderState();
}

class _ChallengeListBuilderState extends State<ChallengeListBuilder> {
  String unityPattern = "unity_challenge.";

  @override
  Widget build(BuildContext context) {
    List<ChallengeModel> _challengesList =
        Provider.of<ChallengesController>(context).getChallenges();

    if (_challengesList.isEmpty) {
      return Container(
        alignment: Alignment.center,
        child: Text(
          "Aucun challenge en cours pourtant tu peux le faire!!!",
          style: TextStyle(
            color: Colors.orange[600],
            fontSize: 18.0,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }
    return ListView.builder(
      itemCount: _challengesList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 3.0, left: 8.0, right: 8.0),
          child: Dismissible(
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                Scaffold.of(context).showSnackBar(_buildSnackBar(
                    content:
                        "Le challenge ${_challengesList[index].name} a bien été validé."));
                // widget.controller.remove(index: index);
              }
              if (direction == DismissDirection.startToEnd) {
                Scaffold.of(context).showSnackBar(
                  _buildSnackBar(
                    content:
                        "Le challenge ${_challengesList[index].name} a bien été supprimé.",
                  ),
                );
                //  widget.controller.remove(index: index);
              }
            },
            confirmDismiss: (direction) async {
              // to confirm delete or not
              if (direction == DismissDirection.startToEnd) {
                final bool resultat = await showDialog<bool>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Confirmation"),
                        content: Text(
                            "Etes-vous sur de vouloir supprimer le challenge?"),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                            child: Text("oui"),
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                            child: Text("Non"),
                          )
                        ],
                      );
                    });
                return resultat;
              }
              return true;
            },
            background: Container(
              color: Colors.red,
              padding: EdgeInsets.only(bottom: 10.0, left: 8.0, right: 8.0),
              alignment: Alignment.centerLeft,
              child: Icon(Icons.delete),
            ),
            secondaryBackground: Container(
              padding: EdgeInsets.only(right: 20.0),
              alignment: Alignment.centerRight,
              color: Colors.green,
              child: Icon(Icons.check),
            ),
            key: Key(UniqueKey().toString()),
            child: Container(
              color: Colors.white,
              child: ListTile(
                title: Text(_challengesList[index].name),
                subtitle: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Objectif:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      SizedBox(width: 10.0),
                      Text(_challengesList[index].target.toString()),
                      SizedBox(width: 5.0),
                      Text(_challengesList[index]
                          .unity
                          .toString()
                          .replaceAll(unityPattern, "")
                          .toUpperCase()),
                    ],
                  ),
                ),
                isThreeLine: true,
              ),
            ),
          ),
        );
      },
    );
  }

  SnackBar _buildSnackBar({@required String content}) {
    return SnackBar(
      content: Text(
        content,
        textAlign: TextAlign.center,
      ),
    );
  }
}
