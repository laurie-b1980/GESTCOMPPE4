import 'package:flutter/material.dart';
import 'package:testflutter/Screens/commandes.dart';
import 'package:testflutter/Services/database.dart';

class DetailCommande extends StatelessWidget {
  String idcommande;
  dynamic nomClient;
  String idclient;
  dynamic article;
  DetailCommande(
      {Key key,
      @required this.idcommande,
      this.idclient,
      this.nomClient,
      this.article});

  DataBaseService db = DataBaseService();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: article,
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.grey,
                title: Text('Détail commande $idcommande'),
              ),
              body: Container(
                padding: EdgeInsets.symmetric(vertical: 70.0, horizontal: 70.0),
                child: Center(
                    child: Column(
                  children: [
                    Text('Nom Client',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('$nomClient'),
                    SizedBox(height: 30.00),
                    Text('Articles',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    for (var element
                        in snapshot.data.docs[0].data()["articles"])
                      Text(element["nom"]),
                    SizedBox(height: 30.00),
                    TextButton(
                        onPressed: () {
                          //await db.supprimerCommande('$idcommande');
                          print('L\'article a comme ID : $idcommande');
                        },
                        child: Text("Supprimer la commande "),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.grey,
                        ))
                  ],
                )),
              ));
        });
  }
}
