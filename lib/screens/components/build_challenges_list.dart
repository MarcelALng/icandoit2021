import 'package:flutter/material.dart';
import '../../models/challenge_model.dart';

class ChallengeListBuilder extends StatefulWidget {
  @override
  _ChallengeListBuilderState createState() => _ChallengeListBuilderState();
}

class _ChallengeListBuilderState extends State<ChallengeListBuilder> {
  List<ChallengeModel> _challengesList = [
    ChallengeModel(name: "Challenge1", target: 23, unity: unity_challenge.kg),
    ChallengeModel(name: "Challenge2", target: 23, unity: unity_challenge.km),
  ];
  String unityPattern = "unity_challenge.";

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _challengesList.length,
      itemBuilder: (context, index) {
        return Dismissible(
          confirmDismiss: (direction) {
            if (direction == DismissDirection.startToEnd) {
              showDialog(
                context:context,
                builder :(context), 
              { return AlertDialog(
                title: Text("test title"),
                content:
                    Text("Etes-vous sur de vouloir supprimer le challenge?"),
                actions: <Widget>[
                  RaisedButton(
                    onPressed: () {},
                    child: Text("oui"),
                  ),
                  RaisedButton(
                    onPressed: () {},
                    child: Text("Non"),
                  )
                ],
              );
            });
            }
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
        );
      },
    );
  }
}
