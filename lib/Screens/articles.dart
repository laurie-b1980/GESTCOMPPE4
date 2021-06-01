import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:testflutter/Screens/AjoutArticles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testflutter/Services/database.dart';
import 'package:testflutter/Screens/detailArticle.dart';

class Articles extends StatefulWidget {
  @override
  _ArticlesState createState() => _ArticlesState();
}

class _ArticlesState extends State<Articles> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  DataBaseService db = DataBaseService();

  Future articles() async {
    return await db.getArticle();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: articles(),
        builder: (context, snapshot) {
          snapshot.data.docs.map((article) {
            return Text(article.data()['Nom article ']);
          }).toList();

          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            print(snapshot);
            return Scaffold(
                appBar: AppBar(
                  title: Text('GESTCOM Articles'),
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
                                  builder: (context) => AjoutArticles()),
                            );
                          },
                          child: Text('Ajouter'),
                        ),
                        // TextButton(onPressed: () {}, child: Text('Rechercher')),
                      ]),
                      Container(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: Column(
                            children: snapshot.data.docs.map<Widget>((article) {
                              return TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailArticle(
                                                  idart: article.id,
                                                  nomart: article
                                                      .data()['Nom article '],
                                                  prix:
                                                      article.data()['Prix HT'],
                                                  stock:
                                                      article.data()['Stock'],
                                                  fournisseur: article
                                                      .data()['Fournisseur'],
                                                )));
                                  },
                                  child: Text(article.data()['Nom article ']));
                            }).toList(),
                          )),
                    ])));
          }

          return Text("Chargement...");
        });
  }
}
