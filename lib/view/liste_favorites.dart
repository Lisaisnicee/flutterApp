import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstbd233/constante/constant.dart';
import 'package:firstbd233/controller/firebase_helper.dart';
import 'package:firstbd233/model/my_user.dart';
import 'package:flutter/material.dart';

class ListFavorites extends StatefulWidget {
  const ListFavorites({super.key});

  @override
  State<ListFavorites> createState() => _ListFavoritesState();
}

class _ListFavoritesState extends State<ListFavorites> {
  @override
  Widget build(BuildContext context) {
    List<String> favorites = moi.favorites;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseHelper().cloud_users.snapshots(),
        builder: (context, snap) {
          if (snap.data == null) {
            return Center(
              child: Text("Aucun favoris"),
            );
          } else {
            List documents = snap.data!.docs;
            print(favorites);
            return Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: Container(
                height: 400,
                child: ListView.builder(
                    itemCount: favorites.length,
                    itemBuilder: (context, index) {
                      String favoriteEmail = favorites[index];
                      MyUser? user =
                          documents.map((doc) => MyUser.bdd(doc)).firstWhere(
                                (user) => user.email == favoriteEmail,
                              );
                      bool isFavorite = favorites.contains(user.email);
                      print(favorites[index]);
                      if (user != null) {
                        return Card(
                          elevation: 5,
                          color: Color.fromARGB(255, 255, 240, 191),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(user.avatar!),
                            ),
                            title: Text(user.fullName),
                            subtitle: Text(user.email),
                            trailing: GestureDetector(
                              child: Icon(isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border),
                              onTap: () {
                                setState(() {
                                  if (isFavorite) {
                                    moi.removeFromFavorites(user.email);
                                  } else {
                                    print("clicked");
                                    moi.addToFavorites(user.email);
                                  }
                                });
                              },
                            ),
                          ),
                        );
                      }
                    }),
              ),
            );
          }
        });
  }
}
