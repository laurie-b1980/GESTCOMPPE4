import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:testflutter/Services/database.dart';

class Commandes extends StatefulWidget {
  @override
  _CommandesState createState() => _CommandesState();
}

class _CommandesState extends State<Commandes> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  DataBaseService db = DataBaseService();

  Future commandes() async {
    return await db.recupCommandes();
  }

  Future client() async {
    return await db.recupClients();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([
          commandes(),
        ]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            print(snapshot.data[0].docs[0].data());
            return Scaffold(
              appBar: AppBar(
                title: Text('GESTCOM commandes'),
                backgroundColor: Colors.grey,
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
                  )
                ],
              ),
              body: Center(
                child: ListView(
                    padding: const EdgeInsets.only(left: 70.0),
                    children: [
                      Container(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: Column(
                            children:
                                snapshot.data[0].docs.map<Widget>((commande) {
                              return TextButton(
                                  onPressed: () {},
                                  child: Text('Numéro :' + commande.id));
                            }).toList(),
                          ))
                    ]),
              ),
            );
          }
          return Text('Chargement...');
        });
  }
}
