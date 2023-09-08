import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstbd233/constante/constant.dart';
import 'package:firstbd233/controller/chat_helper.dart';
import 'package:firstbd233/controller/firebase_helper.dart';
import 'package:firstbd233/model/my_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewAllChats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("hello");
    return StreamBuilder<QuerySnapshot>(
      stream: ChatHelper().cloud_rooms.snapshots(),
      builder: (context, snapshot) {
        print("here");
        if (snapshot.data == null) {
          print("imhere");
          return Center(
            child: Text("Aucun chats"),
          );
        } else {
          List rooms = snapshot.data!.docs;

          print("rooms");
          print(rooms);
          return ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: rooms.length,
              itemBuilder: (context, int index) {
                final room = rooms[index];

                if (isRoomMine(moi.uid, room.id)) {
                  return FutureBuilder<List<Map<String, dynamic>>>(
                    future: ChatHelper().getMessagesFromRoom(room.id),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || snapshot.data == null) {
                        return Center(
                          child: Text("Loading messages..."),
                        );
                      } else {
                        List<Map<String, dynamic>> messages = snapshot.data!;

                        print(messages.first);
                        return Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: Row(
                            children: [
                              CircleAvatar(
                                  radius: 28,
                                  backgroundImage:
                                      NetworkImage(messages[0]["avatar"])),
                              SizedBox(
                                width: 20,
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      messages[0]["receiverName"],
                                    ),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(messages.first["message"]),
                                        ]),
                                  ],
                                ),
                              ),
                              Spacer(),
                              // Add your unread count and time widgets here
                            ],
                          ),
                        );
                      }
                    },
                  );
                } else {
                  return SizedBox.shrink();
                }
              });
        }
      },
    );
  }
}

bool isRoomMine(String uid, String roomId) {
  List<String> parts = roomId.split('_');
  bool isRoomMine = parts.any((part) => part == uid);

  return isRoomMine;
}
