import 'package:flutter/material.dart';
import 'package:testflutter/Screens/clients.dart';
import 'package:testflutter/Screens/commandes.dart';
import 'package:testflutter/Services/database.dart';

class AjoutCommandes extends StatefulWidget {
  String idclient;
  String nom;
  String prenom;
  List<Map> articles;

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
            print("message liste article: ${snapshot.data.docs}");

            return Scaffold(
                appBar: AppBar(
                  title: Text('Commandes'),
                ),
                body: SingleChildScrollView(
                    child: Column(children: [
                  Text('Commande pour le client :  $nom $prenom '),
                  Column(
                      children: snapshot.data.docs.map<Widget>((art) {
                    return Card(
                      child: ListTile(
                          trailing: IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                listeArticle.add({'article': art.id});
                                print(listeArticle);
                              }),
                          title: Text('Nom de l\'article:' +
                              art.data()['Nom article '])),
                    );
                  }).toList()),
                  TextButton(
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
