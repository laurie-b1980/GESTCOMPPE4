/*import 'package:cloud_firestore/cloud_firestore.dart';
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

  TextEditingController _searchcontroller = TextEditingController();

  Future resultsLoaded;
  List _allResults = [];
  List _resultsList = [];

  @override
  void initState() {
    super.initState();
    _searchcontroller.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchcontroller.removeListener(_onSearchChanged);
    _searchcontroller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultsLoaded = rechercheClientStreamSnapshot();
  }

  _onSearchChanged() {
    searchResultList();
    print(_searchcontroller.text);
  }

  searchResultList() {
    var showResults = [];
    if (_searchcontroller.text != "") {
      for (var clientsnapshot in _allResults) {
        var title = rechercheClientStreamSnapshot().title.toLowerCase();
        if (title.contains(_searchcontroller.text.toLowerCase())) {
          showResults.add(clientsnapshot);
        }
      }
    } else {
      showResults = List.from(_allResults);
    }

    setState(() {
      _resultsList = _allResults;
    });
  }

  rechercheClientStreamSnapshot() async {
    var data = await FirebaseFirestore.instance
        .collection('clients')
        .where('nom', isEqualTo: _searchcontroller.text)
        .orderBy('nom')
        .get();
    setState(() {
      _allResults = data.docs;
    });
    searchResultList();
    return "Complet";
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: clients(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            print("message: ${snapshot.data.docs}");
            print("message ");
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
                    padding: const EdgeInsets.only(left: 70.0),
                    children: [
                      Column(children: [
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
                        TextField(
                            controller: _searchcontroller,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.search))),
                        Expanded(
                            child: ListView.builder(
                                itemCount: _resultsList.length,
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        _resultsList[index])),
                        /*TextButton(
                            onPressed: () {
                              /*showSearch(
                                  context: context,
                                  delegate: RechercherItem(widget.listExample));
                              print('$listExample');
                            },*/
                            child: Text('Rechercher'))*/
                      ]),
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
                                                  prenom:
                                                      client.data()['prenom'],
                                                  adresse:
                                                      client.data()['adresse'],
                                                  email: client.data()['email'],
                                                )));
                                    print(client.data()['documentId']);
                                  },
                                  child: Text('Nom du client :' +
                                      client.data()['nom']));
                            }).toList(),
                          ))
                    ]),
              ),
            );
          }
          return Text('Chargement...');
        });
  }
}*/

/*AjoutCommandes(
                                  idclient: idclient,
                                  nom: nom,
                                  prenom: prenom,*/
