import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstbd233/constante/constant.dart';
import 'package:firstbd233/model/my_chat.dart';
import 'package:flutter/material.dart';

class ChatHelper extends ChangeNotifier {
  final cloud_rooms = FirebaseFirestore.instance.collection("ROOMS");

//pour envoyer un message
  Future<void> sendChat(String receiverId, String mess) async {
    //get user
    final Timestamp timestamp = Timestamp.now();
    final String roomId = getRoomId(receiverId);
    //create mess

    Map<String, dynamic> chat = {
      "senderId": moi.uid,
      "receiverId": receiverId,
      "timestamp": timestamp,
      "message": mess
    };
    //create room check if exists or not
    await cloud_rooms.doc(roomId).collection("MESSAGES").add(chat);
    // save mess to database
  }

  //get all chats

  String getRoomId(String receiverId) {
    final Timestamp timestamp = Timestamp.now();

    return 'room_${moi.uid}_${receiverId}_${timestamp}';
  }
}
