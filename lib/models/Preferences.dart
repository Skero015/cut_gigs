import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_gigs/config/preferences.dart';
import 'package:flutter/cupertino.dart';


class Preference{
  String preference;
  String type;

  Preference.fromMap(Map<String, dynamic> data){
    this.type = data['type'];
    this.preference = data['preference'];
  }

  Map<String, dynamic> toMap() {
    return {
      'type' : type,
      'preference': preference,
    };
  }
}

Future<List> getPreferences() async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Users').doc(Preferences.uid)
      .collection('Preferences')
      .get();

  List<dynamic> preferenceList = [];

  snapshot.docs.forEach((element) {
    Preference preference = Preference.fromMap(element.data());
    preferenceList.add(preference);
  });

  return preferenceList;
}