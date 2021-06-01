import 'package:flutter/material.dart';
import 'package:testflutter/Services/auth.dart';

//template pour le formulaire d'inscription

class Inscription extends StatefulWidget {
  final Function transfertPage;
  Inscription({this.transfertPage});
  @override
  _InscriptionState createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  String nom = "";
  String prenom = "";
  String mail = "";
  String motDePass = "";
  String confMDP = "";
  String error = "";

  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
        // Form = conteneur : regroupe et valide plusieurs champs d'un formulaire
        child: Form(
          key: _formKey,
          // Type column permet d'afficher les enfants de manière verticale
          child: Column(children: <Widget>[
            Center(
                child: Text('Bienvenue : créez votre compte !',
                    style: Theme.of(context).textTheme.headline5)),
            SizedBox(height: 10.0),
            // le TextFormField = champ permettant aux utilisateurs de saisir du texte
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Nom',
                border: OutlineInputBorder(),
              ),
              // validation si vide = message
              validator: (val) => val.isEmpty ? 'Entrez votre nom' : null,
              // quand presse button = val prend la valeur de la saisie (la variable)
              onChanged: (val) => nom = val,
            ),
            SizedBox(height: 10.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Prénom',
                border: OutlineInputBorder(),
              ),
              // bo   // validation si vide = message
              validator: (val) => val.isEmpty ? 'Entrez votre prenom' : null,
              // quand presse button = val prend la valeur de la saisie (la variable)
              onChanged: (val) => prenom = val,
            ),
            SizedBox(height: 10.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Adresse mail',
                border: OutlineInputBorder(),
              ),
              // validation si vide = message
              validator: (val) =>
                  val.isEmpty ? 'Entrez votre adresse mail' : null,
              // quand presse button = val prend la valeur de la saisie (la variable)
              onChanged: (val) => mail = val,
            ),
            SizedBox(height: 10.0),
            TextFormField(
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  border: OutlineInputBorder(),
                ),
                // validation si vide = message
                validator: (val) => val.length < 6
                    ? 'Entrez un mot de passe avec plus de 6 caractères'
                    : null,
                // quand presse button = val prend la valeur de la saisie (la variable)
                onChanged: (val) => motDePass = val,
                obscureText: true),

            SizedBox(height: 10.0),
            TextFormField(
                decoration: InputDecoration(
                  labelText: 'Confirmation mot de passe',
                  border: OutlineInputBorder(),
                ),
                // récupération de ce qui est saisi dans la confMDP
                onChanged: (val) => confMDP = val,
                // on fait la vérification que le MDP conf soit identique au MDP mis précédement
                validator: (val) => confMDP != motDePass
                    ? 'Mot de passe ne correspond pas'
                    : null,

                //border ?
                obscureText: true),
            SizedBox(height: 10.0),
            OutlinedButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.grey[600], primary: Colors.white70),
                child: Text('S\'enregistrer'),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    dynamic result = await _auth.registerWithEmailAndPassword(
                        mail, motDePass);
                    if (result == null) {
                      setState(() {
                        error =
                            'Vous êtes déjà enregister : cliquer sur "Avez-vous déjà un compte ?"';
                      });
                    }
                  }
                }),

            SizedBox(height: 10.00),
            OutlinedButton(
                onPressed: () {
                  widget.transfertPage();
                },
                style: TextButton.styleFrom(
                    backgroundColor: Colors.grey[600], primary: Colors.white70),
                child: Text('Avez-vous déjà un compte ?')),
          ]),
        ),
      ),
    ));
  }
}
