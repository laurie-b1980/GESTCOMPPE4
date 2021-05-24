import 'package:flutter/material.dart';

import 'package:testflutter/Services/database.dart';

class DetailCommande extends StatefulWidget {
  dynamic nomClient;
  dynamic prenomClient;
  String email;
  String idclient;
  String idcommande;
  dynamic idarticle;

  DetailCommande(
      {Key key,
      @required this.idclient,
      this.email,
      this.nomClient,
      this.prenomClient,
      this.idarticle,
      this.idcommande});

  @override
  _DetailCommandeState createState() => _DetailCommandeState();
}

class _DetailCommandeState extends State<DetailCommande> {
  DataBaseService db = DataBaseService();

  Future article() async {
    return await db.getArticle();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: article(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.grey,
                title: Text('${widget.idcommande}'),
              ),
              body: Container(
                padding: EdgeInsets.symmetric(vertical: 70.0, horizontal: 70.0),
                child: Center(
                    child: Column(
                  children: [
                    Text('Nom Client',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('blaba'),
                    SizedBox(height: 30.00),
                    Text('Articles',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('nomarticle'),
                    for (var element
                        in snapshot.data.docs[0].data()["articles"])
                      Text(element["nom"]),
                    SizedBox(height: 30.00),
                    TextButton(
                        onPressed: () {
                          //await db.supprimerCommande('$idcommande');
                          print('L\'article a comme ID : ${widget.idcommande}');
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
