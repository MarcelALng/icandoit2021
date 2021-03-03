import 'package:flutter/material.dart';

import 'components/build_challenges_list.dart';

import 'package:icandoit2021/controllers/challenges_controller.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>(); // key which can be use in all application
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  PersistentBottomSheetController _bottomSheetController;
  final ChallengesController _controller = ChallengesController();
  Future<List> challengesData;
  String unityChallenge = "KG";
  String nameChallenge;
  String targetChallenge;

  @override
  void initState() {
    challengesData = _controller.initChallengesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('ICanDOIt'),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: ChallengeListBuilder(
        challengesData: challengesData,
        controller: _controller,
      ), // Careful to write Challenge or ChallengeS
      backgroundColor: Color(0xff414a4c),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: buildBottomSheet(),
    );
  }

  updateController(dynamic value) {
    _bottomSheetController.setState(() {
      unityChallenge = value;
    });
  }

  FloatingActionButton buildBottomSheet() {
    // change to floatingActionButton
    return FloatingActionButton(
      backgroundColor: Colors.orange[700],
      onPressed: () {
        _bottomSheetController =
            scaffoldKey.currentState.showBottomSheet((context) {
          return Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height *
                0.5, // take height from the device
            child: Form(
              // each form need one KEY
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      onSaved: (value) {
                        nameChallenge = value;
                      },
                      validator: (value) {
                        final RegExp checkReg = RegExp(r'^\D+$');
                        if (value.isEmpty) {
                          return "Merci d'entrer un nom pour le challenge";
                        } else if (!checkReg.hasMatch(value)) {
                          return "$value";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Nom du Challenge ",
                      ),
                    ),
                    TextFormField(
                      onSaved: (value) {
                        targetChallenge = value;
                      },
                      validator: (value) {
                        final _isInt =
                            int.tryParse(value); // convert value to int
                        if (_isInt == null) {
                          return "merci d'entrer uniquement des chiffres pour l'objectif";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Objectif",
                      ),
                    ),
                    DropdownButtonFormField(
                      value: unityChallenge,
                      onChanged: (value) {
                        updateController(value);
                      },
                      onSaved: (value) {
                        updateController(value);
                      },
                      items: <DropdownMenuItem>[
                        DropdownMenuItem(
                          value: "KG",
                          child: Text("Kg"),
                        ),
                        DropdownMenuItem(
                          value: "Km",
                          child: Text("Km"),
                        ),
                      ],
                    ), // liste deroulante
                    RaisedButton(
                      onPressed: () {
                        if (formkey.currentState.validate()) {
                          formkey.currentState.save();
                          _controller.addChallenge(
                              name: nameChallenge,
                              target: targetChallenge,
                              unity: unityChallenge);
                          Navigator.pop(context);
                        }
                        ;
                      },
                      child: Text("Ajouter challenge"),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      },
      child: Icon(Icons.add),
    );
  }
}
