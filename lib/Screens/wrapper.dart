import 'package:flutter/material.dart';
import 'package:testflutter/Screens/AjoutArticles.dart';
import 'package:testflutter/Screens/articles.dart';
import 'package:testflutter/Screens/menu.dart';
//import 'package:testflutter/Screens/articles2.dart';
import 'package:testflutter/constants/admin.dart';
import 'package:testflutter/pageAuth/connexion.dart';
import 'package:provider/provider.dart';
import 'package:testflutter/pageAuth/liaisonAuth.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final admin = Provider.of<Admin>(context);
    if (admin == null) {
      return LiaisonPageAuth();
    } else {
      return Menu();
    }
  }
}
