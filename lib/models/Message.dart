
import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String senderID;
  String createdAt;
  String message;

  Message({this.senderID, this.createdAt, this.message});

  Message.fromMap(Map<String, dynamic> data){
    this.senderID = data['senderID'];
    this.message = data['message'];
    this.createdAt = data['createdAt'];
  }

  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'message' : message,
      'createdAt' : createdAt,
    };
  }
}

Stream getChatMessages(String eventID) {
  print('eventID: ' + eventID);
  return FirebaseFirestore.instance
      .collection('Events')
      .doc(eventID)
      .collection('Messages')
      .snapshots();
}