

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_gigs/services/api_services.dart';
import 'package:flutter/cupertino.dart';

class DatabaseService {

  BuildContext context;
  final String uid;
  Api _api = Api('Users');
  DatabaseService({this.uid, this.context});
  String orderNumber;

//Collection Reference
  final CollectionReference userCollection =
  FirebaseFirestore.instance.collection('Users');

  Future addUserData(
      String name, String surname, String phoneNumber ,String email, String title, String country) async {
    return await userCollection.document(uid).setData({
      'name': name,
      'surname': surname,
      'phoneNumber': phoneNumber,
      'email': email,
      'title':title,
      "country": country,
    });
  }

  Future addUserphone(String phoneNumber ) async {
    return await userCollection.document(uid).updateData({
      'phoneNumber': phoneNumber
    });
  }
}