import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstbd233/constante/constant.dart';
import 'package:firstbd233/controller/chat_helper.dart';
import 'package:firstbd233/controller/firebase_helper.dart';
import 'package:firstbd233/model/my_user.dart';
import 'package:firstbd233/widgets/viewAllChats.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    List<String> favorites = moi.favorites;

    return Column(
      children: [
        Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10, top: 120),
              height: 400,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseHelper().cloud_users.snapshots(),
                builder: ((context, snap) {
                  if (snap.data == null) {
                    return Container(
                      child: Center(
                        child: Text(
                            "Ajoutez des personnes à vos favoris pour discuter avec eux."),
                      ),
                    );
                  } else {
                    List documents = snap.data!.docs;
                    String recentMessage;
                    return Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            print("clicked");
                            ChatHelper().sendChat("woIaXlVjOWwe1Q5vCKTP",
                                "how can you do this to me...");
                            setState(() {});
                          },
                          child: Container(
                            alignment: Alignment.topLeft,
                            height: 100,
                            width: 80,
                            child: CircleAvatar(
                              radius: 40,
                              backgroundColor:
                                  const Color.fromARGB(255, 231, 231, 231),
                              child: Center(child: Icon(Icons.chat_sharp)),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(width: 90),
                            Expanded(
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: favorites.length,
                                itemBuilder: (context, index) {
                                  if (index < favorites.length) {
                                    String favoriteEmail = favorites[index];
                                    MyUser? user = documents
                                        .map((doc) => MyUser.bdd(doc))
                                        .firstWhere(
                                          (user) => user.email == favoriteEmail,
                                        );
                                    bool isFavorite =
                                        favorites.contains(user?.email);
                                    if (user != null) {
                                      return Row(
                                        children: [
                                          Column(
                                            children: [
                                              CircleAvatar(
                                                radius: 40,
                                                backgroundImage:
                                                    NetworkImage(user.avatar!),
                                              ),
                                              SizedBox(height: 5),
                                              Container(
                                                child: Text(user.fullName,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400)),
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 10),
                                        ],
                                      );
                                    }
                                  }

                                  return SizedBox.shrink();
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                }),
              ),
            ),
            Column(
              children: [
                SizedBox(height: 220),
                Divider(
                  thickness: 0.5,
                  color: Color.fromARGB(255, 143, 143, 143),
                ),
              ],
            ),
          ],
        ),
        ViewAllChats()
      ],
    );
  }
}
