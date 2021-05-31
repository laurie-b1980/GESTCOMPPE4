import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testflutter/Services/auth.dart';
import 'package:testflutter/Services/database.dart';

class AjoutArticles extends StatefulWidget {
  @override
  _AjoutArticlesState createState() => _AjoutArticlesState();
}

class _AjoutArticlesState extends State<AjoutArticles> {
  final AuthService _auth = AuthService();
  final firestoreInstance = FirebaseFirestore.instance;
  final _formkey = GlobalKey<FormState>();
  String nomart = "";
  double prix;
  int stock;
  String fournisseur = "";
// bouton déconnexion ne fonctionne plus... Rapport avec la base ou le statefull... ?
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.grey,
            title: Text('Ajouter article'),
            actions: <Widget>[
              TextButton.icon(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                },
                icon: Icon(Icons.person),
                label: Text("Déconnexion"),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.blueGrey)),
              ),
            ]),
        body: SingleChildScrollView(
            child: Container(
                padding:
                    EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.00),
                child: Form(
                  key: _formkey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Nom Article',
                              border: OutlineInputBorder(),
                            ),
                            validator: (val) => val.isEmpty
                                ? 'Mettre le nom de l\'article'
                                : null,
                            onChanged: (val) {
                              setState(
                                () => nomart = val,
                              );
                            }),
                        SizedBox(height: 20.0),
                        TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Prix HT',
                              border: OutlineInputBorder(),
                            ),
                            validator: (val) => double.tryParse(val) == null
                                ? 'Veuillez entrer une valeur numérique'
                                : null,
                            onChanged: (val) {
                              setState(() => prix = double.tryParse(val));
                            }),
                        SizedBox(height: 20.0),
                        TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Stock',
                              border: OutlineInputBorder(),
                            ),
                            validator: (val) => int.tryParse(val) == null
                                ? 'Veuillez entrer une valeur numérique'
                                : null,
                            onChanged: (val) {
                              setState(() => stock = int.tryParse(val));
                            }),
                        SizedBox(height: 20.0),
                        TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Nom Fournisseur',
                              border: OutlineInputBorder(),
                            ),
                            validator: (val) => val.isEmpty
                                ? 'Mettre le nom du fournisseur'
                                : null,
                            onChanged: (val) {
                              setState(
                                () => fournisseur = val,
                              );
                            }),
                        SizedBox(height: 20.0),
                        TextButton(
                            child: Text('Enregister'),
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.grey,
                                primary: Colors.white),
                            onPressed: () async {
                              if (_formkey.currentState.validate()) {
                                await DataBaseService().addArticle(
                                    nomart, prix, stock, fournisseur);
                                print('article enregisté');
                              }
                              this.setState(() {
                                Navigator.pop(context);
                              });
                            }),
                      ]),
                ))));
  }
}
