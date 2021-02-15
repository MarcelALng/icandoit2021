import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>(); // key which can be use in all application
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  PersistentBottomSheetController _bottomSheetController;
  String unityChallenge = "KG";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('ICanDOIt'),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
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
                      decoration: InputDecoration(
                        labelText: "Nom du Challenge ",
                      ),
                    ),
                    TextFormField(
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
                      onPressed: () {},
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
