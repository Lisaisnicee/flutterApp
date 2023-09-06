import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstbd233/constante/constant.dart';

class MyUser {
  late String uid;
  late String nom;
  late String prenom;
  late String email;
  String? avatar;
  DateTime? birthday;
  late Genre genre;
  late List<String> favorites = [];
  final cloud_users = FirebaseFirestore.instance.collection("UTILISATEURS");

  MyUser() {
    uid = "";
    nom = "";
    prenom = "";
    email = "";
    genre = Genre.autres;
  }

  MyUser.bdd(DocumentSnapshot snapshot) {
    uid = snapshot.id;
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    nom = map["NOM"];
    prenom = map["PRENOM"];
    email = map["EMAIL"];
    avatar = map["AVATAR"] ?? defaultImage;
    Timestamp? timestamp = map["BIRTHDAY"];
    if (timestamp == null) {
      birthday = DateTime.now();
    } else {
      birthday = timestamp.toDate();
    }
    favorites = (map["favorites"] as List<dynamic>?)?.cast<String>() ?? [];
  }

  //méthode
  String get fullName {
    return prenom + " " + nom;
  }

//pour ajouter un email à la liste des favoris.
  void addToFavorites(String favoriteEmail) {
    if (!favorites.contains(favoriteEmail)) {
      favorites.add(favoriteEmail);
      updateFavoritesFirestore();
    }
  }

//pour supprimer un email de la liste des favoris.
  void removeFromFavorites(String favoriteEmail) {
    if (favorites.contains(favoriteEmail)) {
      favorites.remove(favoriteEmail);
      updateFavoritesFirestore();
    }
  }

//pour update la base de données
  void updateFavoritesFirestore() {
    cloud_users.doc(uid).update({
      'favorites': favorites,
    }).then((_) {
      print('bravo');
    }).catchError((error) {
      print('fail: $error');
    });
  }
}
