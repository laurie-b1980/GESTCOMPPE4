import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:testflutter/Screens/AjoutClient.dart';
import 'package:testflutter/Screens/ajoutCommande.dart';
import 'package:testflutter/Screens/clients.dart';
import 'package:testflutter/Services/database.dart';
import 'package:testflutter/Screens/commandes.dart';
import 'package:testflutter/Screens/detailCommandes.dart';

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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([commandes()]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.done) {
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
                      Row(children: [
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
                        TextButton(onPressed: () {}, child: Text('Rechercher')),
                      ]),
                      Container(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: Column(
                            children:
                                snapshot.data[0].docs.map<Widget>((commande) {
                              return TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailCommande(
                                                idcommande: commande.id,
                                                nomClient:
                                                    db.recupNomClientInCommande(
                                                        commande.id),
                                                idarticle:
                                                    db.recupArticlesInCommande(
                                                        commande.id))));
                                    print('bbbb');
                                  },
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

/*
                                            builder: (context) => DetailClient(
                                                  idclient: client.id,
                                                  nom: client.data()['nom'],
                                                  prenom:
                                                      client.data()['prenom'],
                                                  adresse:
                                                      client.data()['adresse'],
                                                  email: client.data()['email'],
                                                )));
                                    print(client.data()['documentId']);}}*/
