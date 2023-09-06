import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstbd233/constante/constant.dart';
import 'package:firstbd233/controller/firebase_helper.dart';
import 'package:firstbd233/model/my_user.dart';
import 'package:firstbd233/widgets/viewProfile.dart';
import 'package:flutter/material.dart';

class ListPersonne extends StatefulWidget {
  const ListPersonne({super.key});

  @override
  State<ListPersonne> createState() => _ListPersonneState();
}

class _ListPersonneState extends State<ListPersonne> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseHelper().cloud_users.snapshots(),
        builder: (context, snap) {
          if (snap.data == null) {
            return Center(
              child: Text("Aucun utilisateur"),
            );
          } else {
            List documents = snap.data!.docs;
            List docs = documents.where((doc) {
              MyUser user = MyUser.bdd(doc);
              return moi.email != user.email;
            }).toList();
            return Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: Container(
                height: 400,
                child: ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      List<String> favorites = moi.favorites;
                      MyUser users = MyUser.bdd(docs[index]);
                      bool isFavorite = favorites.contains(users.email);

                      if (moi.email != users.email) {
                        return GestureDetector(
                          onTap: () {
                            showDialog(
                              builder: (context) => ViewProfile(
                                user: users,
                              ),
                              context: context,
                            );
                          },
                          child: Card(
                            elevation: 5,
                            color: Color.fromARGB(255, 255, 240, 191),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(users.avatar!),
                              ),
                              title: Text(users.fullName),
                              subtitle: Text(users.email),
                              trailing: GestureDetector(
                                child: Icon(isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border),
                                onTap: () {
                                  setState(() {
                                    if (isFavorite) {
                                      moi.removeFromFavorites(users.email);
                                    } else {
                                      print("clicked");
                                      moi.addToFavorites(users.email);
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    }),
              ),
            );
          }
        });
  }
}
