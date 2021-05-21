import 'package:flutter/material.dart';
import 'package:testflutter/Screens/ajoutCommande.dart';
import 'package:testflutter/Services/articlelistcommande.dart';
import 'package:testflutter/Services/database.dart';
import 'package:testflutter/Screens/clients.dart';

class DetailClient extends StatelessWidget {
  String idclient;
  String nom;
  String prenom;
  String adresse;
  String email;
  DetailClient(
      {Key key,
      @required this.idclient,
      this.nom,
      this.prenom,
      this.adresse,
      this.email});

  DataBaseService db = DataBaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Text('Détail client $nom '),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 70.0, horizontal: 70.0),
          child: Center(
              child: Column(
            children: [
              Text('Nom', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('$nom'),
              SizedBox(height: 30.00),
              Text('Prénom', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('$prenom'),
              SizedBox(height: 30.00),
              Text('Adresse', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('$adresse'),
              SizedBox(height: 30.00),
              Text('Email', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('$email'),
              SizedBox(height: 30.00),
              TextButton(
                  onPressed: () async {
                    await db.deleteArticle('$idclient');
                    print('L\'article a comme ID : $idclient');
                  },
                  child: Text("Supprimer client "),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.grey,
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AjoutCommandes(
                                  idclient: idclient,
                                  nom: nom,
                                  prenom: prenom,
                                )));
                  },
                  child: Text('Ajouter une commande'),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.grey,
                  ))
            ],
          )),
        ));
  }
}

/*
AjoutCommandes(
                                  idclient: idclient,
                                  nom: nom,
                                  prenom: prenom,
                                )*/
