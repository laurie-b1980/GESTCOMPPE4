import 'package:flutter/material.dart';
import 'package:testflutter/pageAuth/connexion.dart';
import 'package:testflutter/pageAuth/inscription.dart';

class LiaisonPageAuth extends StatefulWidget {
  @override
  _LiaisonPageAuth createState() => _LiaisonPageAuth();
}

class _LiaisonPageAuth extends State<LiaisonPageAuth> {
  bool affichePageConnexion = true;

  void transfertPage() {
    setState(() => affichePageConnexion = !affichePageConnexion);
  }

  @override
  Widget build(BuildContext context) {
    if (affichePageConnexion) {
      return Connexion(transfertPage: transfertPage);
    } else {
      return Inscription(transfertPage: transfertPage);
    }
  }
}
