/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testflutter/Screens/ajoutCommande.dart';
import 'package:testflutter/Services/database.dart';

class ArticleCommande extends StatefulWidget {
  @override
  _ArticleCommandeState createState() => _ArticleCommandeState();
}

class _ArticleCommandeState extends State<ArticleCommande> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

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
            return Container(
                child: Column(
                    children: snapshot.data.docs.map<Widget>((art) {
              return Card(
                child: ListTile(
                    trailing: IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          listeArticle.add({'article': art.id});
                          print(listeArticle);
                        }),
                    title: Text(
                        'Nom de l\'article:' + art.data()['Nom article '])),
              );
            }).toList()));
          }
          return Text('Chargement...');
        });
  }
}*/
/*Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AjoutCommandes(),
                                  settings:
                                      RouteSettings(arguments: listeArticle)));*/
