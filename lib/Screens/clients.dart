import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testflutter/Screens/AjoutClient.dart';

import 'package:testflutter/services/database.dart';
import 'package:testflutter/Screens/detailClient.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Clients extends StatefulWidget {
  @override
  _ClientsState createState() => _ClientsState();
}

class _ClientsState extends State<Clients> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  DataBaseService db = DataBaseService();

  Future clients() async {
    return await db.recupClients();
  }

  Future list;
  Future filtered;

  @override
  void initState() {
    list = clients();
    filtered = list;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: filtered,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            print("message: ${snapshot.data.docs}");

            return Scaffold(
              appBar: AppBar(
                title: Text('GESTCOM clients'),
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
                  ),
                ],
              ),
              body: Center(
                child: ListView(
                    padding: const EdgeInsets.only(left: 70.0),
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ajoutClient()),
                          );
                        },
                        child: Text('Ajouter'),
                      ),
                      TextField(
                        onChanged: (val) {
                          val = val.toLowerCase();
                          setState(() async {
                            dynamic myList = await list;
                            print(myList.docs);
                            filtered = myList.docs
                                .where((element) => element
                                    .data()['nom']
                                    .toLowerCase()
                                    .contains(val))
                                .toList();
                          });
                        },
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: Column(
                            children: snapshot.data.docs.map<Widget>((client) {
                              return TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailClient(
                                                  idclient: client.id,
                                                  nom: client.data()['nom'],
                                                  prenom:
                                                      client.data()['prenom'],
                                                  adresse:
                                                      client.data()['adresse'],
                                                  email: client.data()['email'],
                                                )));
                                    print(client.data()['documentId']);
                                  },
                                  child: Text('Nom du client :' +
                                      client.data()['nom']));
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

/*AjoutCommandes(
                                  idclient: idclient,
                                  nom: nom,
                                  prenom: prenom,*/
