import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstbd233/constante/constant.dart';

class MyChat {
  // final cloud_messages = FirebaseFirestore.instance.collection("MESSAGES");
  final String message;
  final String receiverId;
  final String senderId;
  final Timestamp timestamp;

  MyChat(
      {required this.message,
      required this.receiverId,
      required this.senderId,
      required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'message': message,
      'receivedId': receiverId,
      'timestamp': timestamp,
    };
  }
}
