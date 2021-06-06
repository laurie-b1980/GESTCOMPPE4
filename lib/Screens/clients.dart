import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:testflutter/Screens/AjoutClient.dart';
import 'package:testflutter/services/database.dart';
import 'package:testflutter/Screens/detailClient.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Clients extends StatefulWidget {
  @override
  _ClientsState createState() => _ClientsState();
}

class _ClientsState extends State<Clients> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  DataBaseService db = DataBaseService();

  Future clients() async {
    return await db.recupClients();
  }
  //Future list;
  //Future filtered

  /*Future list;
  Future filtered;
  @override
  void initState() {
    super.initState();(à voir)
    list = clients();
    filtered = list;
  }*/

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: clients(),
        //future : filterd;
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                title: Text('GESTCOM clients'),
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
                  ),
                ],
              ),
              body: Center(
                  child: ListView(
                      padding: const EdgeInsets.only(left: 10.0),
                      children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ajoutClient()),
                        );
                      },
                      child: Text('Ajouter'),
                    ),
                    // test bouton simple :
                    /*Container(
                      child: TextButton(
                        onPressed: () {},
                        child: Text('Voici un bouton'),
                      ),
                    ),*/
                    TextField(
                        /* onChanged: (val) {
                          val = val.toLowerCase();
                          setState(() async {
                            dynamic myList = await list;
                            print(myList.docs);
                            filtered = myList.docs
                                .where((element) => element
                                    .data()['nom']
                                    .toLowerCase()
                                    .contains(val))
                                .toList();
                          });
                        },*/
                        ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                      child: Column(
                        children: snapshot.data.docs.map<Widget>((client) {
                          return TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailClient(
                                              idclient: client.id,
                                              nom: client.data()['nom'],
                                              prenom: client.data()['prenom'],
                                              adresse: client.data()['adresse'],
                                              email: client.data()['email'],
                                            )));
                                print(client.data()['documentId']);
                              },
                              child: Text(
                                  'Nom du client :' + client.data()['nom']));
                        }).toList(),
                      ),
                    ),
                    //Test Bouton : avec ICON
                    /*Container(
                        child: TextButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.list_sharp),
                            label: Text('Voici mon bouton')))*/
                  ])),
            );
          }
          return Text('Chargement...');
        });
  }
}
/*  return client.data().sort((a, b) => {
                                    a['nom']
                                        .toLowerCase()
                                        .comparaTo(b['nom'].toLowerCase())
                                  });*/
