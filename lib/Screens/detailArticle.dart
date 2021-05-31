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
                            db.deleteArticle('$idart');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Articles(),
                                ));
                          },
                          child: const Text('Confirmer'),
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
            ],
          )),
        ));
  }
}
