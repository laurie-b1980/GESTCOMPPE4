import 'package:flutter/material.dart';
import 'package:testflutter/Screens/articles.dart';
import 'package:testflutter/Services/database.dart';

class DetailArticle extends StatelessWidget {
  String idart;
  String nomart = "";
  double prix;
  int stock;
  String fournisseur = "";
  DetailArticle(
      {Key key,
      @required this.idart,
      this.nomart,
      this.prix,
      this.stock,
      this.fournisseur});

  DataBaseService db = DataBaseService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Text('Détail article $nomart'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 70.0, horizontal: 70.0),
          child: Center(
              child: Column(
            children: [
              Text('Nom Article',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text('$nomart'),
              SizedBox(height: 30.00),
              Text('Prix HT', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('$prix'),
              SizedBox(height: 30.00),
              Text('Stock', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('$stock'),
              SizedBox(height: 30.00),
              Text('Fournisseur',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text('$fournisseur'),
              SizedBox(height: 30.00),
              TextButton(
                  onPressed: () async {
                    await db.deleteArticle('$idart');
                    print('L\'article a comme ID : $idart');
                  },
                  child: Text("Supprimer article "),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.grey,
                  ))
            ],
          )),
        ));
  }
}
