/*import 'package:flutter/material.dart';
import 'package:testflutter/Services/articlelistcommande.dart';
import 'package:testflutter/Services/database.dart';

class AjoutCommandes extends StatelessWidget {
  String idclient;
  String nom;
  String prenom;
  List<Map> articles;
  String idart;
  String nomart = "";
  double prix;
  int stock;

  ArticleCommande articleView = ArticleCommande();

  DataBaseService db = DataBaseService();

  AjoutCommandes(
      {Key key, @required this.idclient, this.nom, this.prenom, this.articles});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Commandes'),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Text('Commande pour le client : $nom $prenom '),
            articleView,
            TextButton(
                onPressed: () async {
                  await db.ajoutCommandes(idclient, []);
                  print(idclient);
                },
                child: Text('Enregistrer la commande'))
          ]),
        ));
  }
}*/
