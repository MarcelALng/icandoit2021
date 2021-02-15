import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey(); // key which can be use in all application
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

 String unityChallege = "KG",

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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange[700],
        onPressed: () {
          buildBottomSheet();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  FloatingActionButton buildBottomSheet() { // change to floatingActionButton
    return scaffoldKey.currentState.showBottomSheet((builder) {
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
                    decoration: InputDecoration(
                      labelText: "objectif",
                    ),
                  ),
                  DropdownButtonFormField(
                    value: unityChallenge,
                    onChanged: (value) {
                      setState(() {
                        unityChallenge = value;
                      });
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
          ));
    });
  }
}