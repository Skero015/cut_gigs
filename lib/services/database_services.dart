

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_gigs/models/Category.dart';
import 'package:cut_gigs/models/Favourite.dart';
import 'package:cut_gigs/notifiers/event_notifier.dart';
import 'package:cut_gigs/services/api_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  final CollectionReference eventCollection =
  FirebaseFirestore.instance.collection('Events');

  final CollectionReference tagCollection =
  FirebaseFirestore.instance.collection('Tags');
  
  Reference speakerStorageRef = FirebaseStorage.instance.ref().child('speakers/');

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

  Future<String> uploadSpeakerImage (EventNotifier eventNotifier, String imageName, File imageFile) async {

    String downloadUrl;

    try{
      speakerStorageRef = speakerStorageRef.child(eventNotifier.currentEvent.eventID + "/" + uid);
      await speakerStorageRef.putFile(imageFile).whenComplete(() async{

        downloadUrl = await speakerStorageRef.getDownloadURL();
      });


    }catch(e){
      print(e);
    }

    return downloadUrl;

  }

  Future updateEventSpeaker (EventNotifier eventNotifier, String companyName, String image, String topic, String position, tagID) async{

    try{

      await eventCollection.doc(eventNotifier.currentEvent.eventID).collection('Speakers').doc(uid).set({
        'email' : FirebaseAuth.instance.currentUser.email,
        'eventID' : eventNotifier.currentEvent.eventID,
        'companyName' : companyName,
        'image' : image,
        'name' : FirebaseAuth.instance.currentUser.displayName,
        'position' : "",
        'speakerID' : uid,
        'topic' : topic,
        'userID' : uid,
        'isApproved' : false,
        'tagID' : "",
      }).whenComplete(() async{
        await tagCollection.doc(tagID).set({
          'attendeeID': uid,
          'tagID': tagID,
          'eventID': eventNotifier.currentEvent.eventID,
        });
      });

    }catch(e){

    }

  }

  Future updateEventAttendee (EventNotifier eventNotifier, tagID) async{

    try{
      await userCollection.doc(uid).collection('Events').doc(eventNotifier.currentEvent.eventID).set({
        'eventID' : eventNotifier.currentEvent.eventID,
        'tagID': tagID,
        'isFavourite': eventNotifier.currentEvent.isFavourite,
      }).whenComplete(() async{

        await eventCollection.doc(eventNotifier.currentEvent.eventID).collection('Attendees').doc(uid).set({
          'userID' : uid,
          'tagID' : tagID,
        }).whenComplete(() async{

          await tagCollection.doc(tagID).set({
            'attendeeID': uid,
            'tagID': tagID,
            'eventID': eventNotifier.currentEvent.eventID,
          });
        });
      });

    }catch(e){
      print(e.toString());
    }
  }
}