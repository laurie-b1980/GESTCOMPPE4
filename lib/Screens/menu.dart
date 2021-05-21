import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:testflutter/Screens/articles.dart';
import 'package:testflutter/Screens/clients.dart';
import 'package:testflutter/Screens/Commandes.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('GESTCOM Menu'),
          backgroundColor: Colors.grey,
          actions: <Widget>[
            TextButton.icon(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              icon: Icon(Icons.person),
              label: Text("Déconnexion"),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blueGrey)),
            )
          ],
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Articles()));
                  },
                  child: Text('Articles'),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.grey,
                  )),
              SizedBox(height: 20.0),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Clients()));
                  }, // pour le moment redirigé vers Articles
                  child: Text('Clients'),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.grey,
                  )),
              SizedBox(height: 20.0),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Commandes()));
                  }, //pour le moment redirigé vers Articles
                  child: Text('Commandes'),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.grey,
                  )),
            ],
          ),
        ));
  }
}
