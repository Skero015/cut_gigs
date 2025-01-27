import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';


class Speaker{
  String name;
  String image;
  String companyName;
  String position;
  String topic;
  String speakerID;
  String userID;
  String eventID;
  String email;
  bool isApproved;


  Speaker.fromMap(Map<String, dynamic> data){
    this.name = data['name'];
    this.image = data['image'];
    this.companyName = data['companyName'];
    this.position = data['position'];
    this.topic = data['topic'];
    this.speakerID = data['speakerID'];
    this.userID = data['userID'];
    this.eventID = data['eventID'];
    this.email = data['email'];
    this.isApproved = data['isApproved'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'companyName': companyName,
      'position': position,
      'topic': topic,
      'email' : email,
      'speakerID': speakerID,
      'userID': userID,
      'eventID': eventID,
      'isApproved' : isApproved,
    };
  }
}

Future<List> getSpeakers(String eventID) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('Events')
      .doc(eventID)
      .collection('Speakers')
      .get();

  List<dynamic> speakerList = [];

  snapshot.docs.forEach((element) {
    Speaker speaker = Speaker.fromMap(element.data());
    speakerList.add(speaker);
  });

  return speakerList;
}