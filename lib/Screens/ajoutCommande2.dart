import 'dart:math';

import 'package:flutter/material.dart';
import 'package:testflutter/Screens/commandes.dart';
import 'package:testflutter/Services/database.dart';

class AjoutCommandes extends StatefulWidget {
  String idclient;
  String nom;
  String prenom;
  List<Map> articles;
  double sommeprix = 0;
  String total = "";

  AjoutCommandes(
      {Key key, @required this.idclient, this.nom, this.prenom, this.articles});

  @override
  _AjoutCommandesState createState() =>
      _AjoutCommandesState(idclient: idclient, nom: nom, prenom: prenom);
}

class _AjoutCommandesState extends State<AjoutCommandes> {
  String idart;
  String nomart = "";
  double prix;
  int stock;
  String idclient;
  String nom;
  String prenom;
  double sommeprix = 0;
  String total = "";

  _AjoutCommandesState({
    Key key,
    @required this.idclient,
    this.nom,
    this.prenom,
  });
  List<Map> listeArticle = [];

  List<Map> getListeArticle() => listeArticle;
  DataBaseService db = DataBaseService();
  Future articles() async {
    return await db.getArticle();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: articles(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
                appBar: AppBar(
                  title: Text('Commandes'),
                  backgroundColor: Colors.grey,
                  elevation: 0.0,
                ),
                body: SingleChildScrollView(
                    child: Column(children: [
                  Text('Commande pour le client :  $nom $prenom ',
                      style: TextStyle(fontSize: 20)),
                  Column(
                    children: snapshot.data.docs.map<Widget>((art) {
                      return Container(
                        height: 100,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: ListTile(
                            trailing: IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  listeArticle.add({
                                    'article': art.id,
                                    'prix': art.data()['Prix HT'],
                                    'nom': art.data()["Nom article "]
                                  });
                                  print(listeArticle);
                                  print(art.data()['Prix HT']);
                                  sommeprix =
                                      sommeprix + (art.data()['Prix HT']);
                                  print(sommeprix);
                                  total = sommeprix.toString();
                                  print('total commande :' + total);
                                }),
                            title: Text('Nom de l\'article: ' +
                                art.data()['Nom article ']),
                            subtitle: Text('Prix de l\'article: ' +
                                art.data()['Prix HT'].toString() +
                                '€'),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  Text('Total commande :' + total),
                  TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.grey, primary: Colors.white),
                      onPressed: () async {
                        await db.ajoutCommandes(idclient, listeArticle);
                        print(widget.idclient);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Commandes()));
                      },
                      child: Text('Enregistrer la commande')),
                ])));
          }

          return Text('Chargement...');
        });
  }
}
