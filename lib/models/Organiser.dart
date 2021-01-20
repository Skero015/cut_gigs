import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';


class Organiser{
  String name;
  String image;
  String message;

  Organiser.fromMap(Map<String, dynamic> data){
    this.name = data['name'];
    this.image = data['image'];
    this.message = data['message'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'message' : message,
    };
  }
}

Future<List> getOrganisers(String eventID) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('Events')
      .doc(eventID)
      .collection('Organisers')
      .get();

  List<dynamic> organiserList = [];

  snapshot.docs.forEach((element) {
    Organiser organiser = Organiser.fromMap(element.data());
    organiserList.add(organiser);
  });

  return organiserList;
}