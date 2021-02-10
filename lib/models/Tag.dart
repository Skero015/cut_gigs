import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';


class Tag{
  String eventID;
  String tagID;
  String attendeeID;

  Tag.fromMap(Map<String, dynamic> data){
    this.tagID = data['tagID'];
    this.eventID = data['eventID'];
    this.attendeeID = data['attendeeID'];
  }

  Map<String, dynamic> toMap() {
    return {
      'tagID': tagID,
      'eventID': eventID,
      'attendeeID': attendeeID,
    };
  }
}

Future<List> getTagID() async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('Tags')
      .get();

  List<dynamic> tagList = [];

  snapshot.docs.forEach((element) {
    Tag tag = Tag.fromMap(element.data());
    tagList.add(tag);
  });

  return tagList;
}