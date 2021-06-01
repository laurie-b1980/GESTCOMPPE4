import 'package:flutter/material.dart';
import 'package:testflutter/Services/auth.dart';

class Connexion extends StatefulWidget {
  final Function transfertPage;
  Connexion({this.transfertPage});
  @override
  _ConnexionState createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  String mail = "";
  String motDePass = "";
  String error = "";

  final AuthService _auth = AuthService();

  final _keyForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.00),
          child: Form(
            key: _keyForm,
            child: Column(
              // crossAwisAligment = taille du child sur la page (parle horizontalement) + stretch = va prendre toute la largeur
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                  child: Text('Bienvenue chez GESTCOM ! ',
                      style: Theme.of(context).textTheme.headline5),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Votre mail',
                    border: OutlineInputBorder(),
                  ),
                  validator: (val) =>
                      val.isEmpty ? 'Indiquez votre mail' : null,
                  onChanged: (val) => mail = val,
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Votre mot de passe',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (val) => val.length < 6
                      ? 'Votre mot de passe doit contenir au maximum 6 caractères'
                      : null,
                  onChanged: (val) => motDePass = val,
                ),
                OutlinedButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.grey[700],
                        primary: Colors.white),
                    child: Text('S\'authentifier'),
                    onPressed: () async {
                      if (_keyForm.currentState.validate()) {
                        dynamic result = await _auth.signInWithEmailAndPassword(
                            mail, motDePass);
                        if (result == null) {
                          setState(() {
                            error =
                                'Vous n\'êtes pas enregistré enregistré vous avant';
                          });
                        }
                      }
                    }),
                SizedBox(height: 10.00),
                ElevatedButton(
                  onPressed: () {
                    widget.transfertPage();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    primary: Colors.black,
                  ),
                  child: Text('Besoin d\'un nouveau compte ? '),
                ),
              ],
            ),
          )),
    ));
  }
}
