import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:testflutter/Screens/clients.dart';
import 'package:testflutter/services/auth.dart';
import 'package:testflutter/services/database.dart';

class ajoutClient extends StatefulWidget {
  @override
  _ajoutClientState createState() => _ajoutClientState();
}

// ignore: camel_case_types
class _ajoutClientState extends State<ajoutClient> {
  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();

  String nom;
  String prenom;
  String adresse;
  String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Ajouter client"),
          backgroundColor: Colors.grey,
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              icon: Icon(Icons.person),
              label: Text("Déconnexion"),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blueGrey)),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                  key: _formKey,
                  child: Column(children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: InputDecoration(hintText: "Nom"),
                      onChanged: (val) {
                        setState(() => nom = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: InputDecoration(hintText: "Prénom"),
                      onChanged: (val) {
                        setState(() => prenom = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: InputDecoration(hintText: "Adresse"),
                      onChanged: (val) {
                        setState(() => adresse = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: InputDecoration(hintText: "email"),
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.grey, primary: Colors.white),
                      child: Text(
                        'Ajouter',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await DataBaseService()
                              .ajoutClient(nom, prenom, adresse, email);
                        }
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Clients()));
                      },
                    )
                  ]))),
        ));
  }
}
