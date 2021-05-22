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
                onPressed: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title:
                          Text('Etes vous sur de vouloir supprimer Article  ?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Annuler'),
                          child: const Text('Annuler'),
                        ),
                        TextButton(
                          onPressed: () {
                            db.deleteArticle('$idclient');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Clients(),
                                ));
                          },
                          child: const Text('Confirmez'),
                        )
                      ],
                    ),
                  );
                },
                child: Text(
                  "Supprimer",
                  style: TextStyle(color: Colors.white, fontSize: 15.0),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.grey,
                ),
              ),
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
