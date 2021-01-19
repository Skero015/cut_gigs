import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';


class Sponsor{
  String title;
  String image;

  Sponsor.fromMap(Map<String, dynamic> data){
    this.title = data['title'];
    this.image = data['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'image': image,
    };
  }
}

Future<List> getSponsors(String eventID) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('Events')
      .doc(eventID)
      .collection('Sponsors')
      .get();

  List<dynamic> sponsorList = [];

  snapshot.docs.forEach((element) {
    Sponsor sponsor = Sponsor.fromMap(element.data());
    sponsorList.add(sponsor);
  });

  return sponsorList;
}