

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_gigs/models/Category.dart';
import 'package:cut_gigs/models/Favourite.dart';
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
    return await userCollection.doc(uid).set({
      'name': name,
      'surname': surname,
      'phoneNumber': phoneNumber,
      'email': email,
      'title':title,
      "country": country,
      'isAdmin' : false,
      'isHost' : false,
    });
  }

  Future addUserphone(String phoneNumber ) async {
    return await userCollection.doc(uid).update({
      'phoneNumber': phoneNumber
    });
  }

  Future updateEventFavourites(bool isFavourite, String eventID) async {

    try{
      await userCollection.doc(uid).collection('Events').doc(eventID).get().then((doc) async{
        if(doc.exists){
          return await userCollection.doc(uid).collection('Events').doc(eventID).update({
            'isFavourite' : isFavourite
          });
        }else{
          return await userCollection.doc(uid).collection('Events').doc(eventID).set({
            'eventID' : isFavourite,
            'isFavourite' : isFavourite,
            'tagID' : "",
          });
        }

      });

      print('done changing favs');
    }catch(e){
      print(e.toString());
    }

  }

  Future<List> getEventFavourites() async{

    QuerySnapshot snapshot = await userCollection.doc(uid)
        .collection('Events')
        .get();

    List<dynamic> favouritesList = [];

    snapshot.docs.forEach((element) {
      Favourite favourite = Favourite.fromMap(element.data());
      favouritesList.add(favourite);
    });

    return favouritesList;
  }
}