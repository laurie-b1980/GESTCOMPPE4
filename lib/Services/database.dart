import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testflutter/Screens/commandes.dart';

class DataBaseService {
  //Articles collection reference
  final CollectionReference articles =
      FirebaseFirestore.instance.collection('articles');
  // Clients collection reference
  final CollectionReference clients =
      FirebaseFirestore.instance.collection('clients');
  //Commandes collection refence
  final CollectionReference commandes =
      FirebaseFirestore.instance.collection('commandes');

// Ajouter un article :
  Future addArticle(
      String nomart, double prix, int stock, String fournisseur) async {
    try {
      await articles.add({
        "Nom article ": nomart,
        "Prix HT": prix,
        "Stock": stock,
        "Fournisseur": fournisseur,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  // Récupérer les articles
  Future getArticle() async {
    return await articles.get();
  }

//supprimer un article
  Future deleteArticle(String id) async {
    await articles.doc(id).delete();
  }

  //Ajouter client
  Future ajoutClient(
      String nom, String prenom, String adresse, String email) async {
    return await clients.add(
        {"nom": nom, "prenom": prenom, "adresse": adresse, "email": email});
  }

  //Récuperer client
  Future recupClients() async {
    print('hello');
    return await clients.get();
  }

// supprimer client
  Future supprimerClient(String id) async {
    print('Ok');
    await clients.doc(id).delete();
  }

  //Ajouter une commande
  Future ajoutCommandes(String idclient, List<Map> articles) async {
    try {
      dynamic commande = await commandes.add({'idclient': idclient});
      return await commandes
          .doc(commande.id)
          .collection('articles')
          .add({'articles': articles});
    } catch (e) {
      print(e.toString());
    }
  }

  //Récupérer commande
  Future recupCommandes() async {
    print('Alors cette commande apparaît!!!! ');
    return await commandes.get();
  }

  Future recupArticlesInCommande(String id) async {
    return await FirebaseFirestore.instance
        .collection("commandes/$id/articles")
        .get();
  }

  Future recupNomClientInCommande(String id) async {
    dynamic nomcli =
        await FirebaseFirestore.instance.collection("clients").doc(id).get();
    return nomcli;
  }

  Future supprimerCommande(String id) async {
    print('Ok');
    await commandes.doc(id).delete();
  }
}
