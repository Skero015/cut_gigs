

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_gigs/config/preferences.dart';
import 'package:cut_gigs/notifiers/event_notifier.dart';
import 'package:cut_gigs/services/database_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class Event {

  String eventID;
  String title;
  String about;
  Timestamp date;
  Timestamp endDate;
  String category;
  String faqs;
  String schedule;
  String survey;
  String hostID;
  String image;
  String institutionID;
  String location;
  String locationLatitude;
  String locationLongitude;
  String mapPDF;
  String mealPDF;
  String venue;
  String password;
  bool isPriority;
  bool isPrivate;
  bool isFavourite;
  String tagID;

  Event(
      this.eventID,
      this.title,
      this.about,
      this.category,
      this.faqs,
      this.schedule,
      this.hostID,
      this.image,
      this.institutionID,
      this.location,
      this.locationLatitude,
      this.locationLongitude,
      this.mapPDF,
      this.mealPDF,
      this.venue,
      this.password,
      this.isPriority,
      this.isPrivate,
      this.isFavourite);

  Event.fromMap(Map<String, dynamic> data){
    this.eventID = data['eventID'];
    this.title = data['title'];
    this.date = data['date'];
    this.endDate = data['endDate'];
    this.about = data['about'];
    this.category = data['category'];
    this.faqs = data['faqs'];
    this.schedule = data['schedule'];
    this.survey = data['survey'];
    this.hostID = data['hostID'];
    this.image = data['image'];
    this.institutionID = data['institutionID'];
    this.venue = data['venue'];
    this.location = data['location'];
    this.locationLatitude = data['locationLatitude'];
    this.locationLongitude = data['locationLongitude'];
    this.mapPDF = data['mapPDF'];
    this.mealPDF = data['mealPlan'];
    this.password = data['password'];
    this.isPriority = data['isPriority'];
    this.isPrivate = data['isPrivate'];
    this.isFavourite = data['isFavourite'];
  }

  Map<String, dynamic> toMap() {
    return {
      'eventID' : eventID,
      'title': title,
      'about': about,
      'date' : date,
      'endDate' : endDate,
      'category': category,
      'faqs': faqs,
      'schedule': schedule,
      'survey' : survey,
      'hostID': hostID,
      'image': image,
      'institutionID': institutionID,
      'venue': venue,
      'location' : location,
      'locationLongitude': locationLongitude,
      'locationLatitude': locationLatitude,
      'mapPDF' : mapPDF,
      'mealPlan' : mealPDF,
      'password': password,
      'isPriority': isPriority,
      'isPrivate': isPrivate,
      'isFavourite' : isFavourite,
    };
  }
}

Future<List> getEvents(BuildContext context, EventNotifier eventNotifier, String widgetName) async{
  QuerySnapshot snapshots;
  DocumentSnapshot docSnapshot;

  List<Event> _eventList = [];

  print("context " + context.toString());
  try{
    print("getting fav events");
    await DatabaseService(uid: Preferences.uid).getEventFavourites().then((value) async {

      print('got fav events in user collection');
      if(context.toString().contains("FavouritesScreen") || context.toString().contains("MyEventsScreen")){
        print('inside if statement');

        int i = 0;

        while(i < value.length){
          docSnapshot = await FirebaseFirestore.instance
              .collection('Events')
              .doc(value[i].eventID)
              .get();

          Event event = Event.fromMap(docSnapshot.data());
          event.isFavourite = value.singleWhere((elmnt) => elmnt.eventID == event.eventID).isFavourite;
          event.tagID = value.singleWhere((elmnt) => elmnt.eventID == event.eventID).tagID;
          _eventList.add(event);

          if(value[i].tagID.toString().trim().isNotEmpty){
            FirebaseFirestore.instance
                .collection('Events')
                .doc(value[i].eventID)
                .collection('Tokens')
                .doc(Preferences.fcmToken).set({
              'token' : Preferences.fcmToken,
            });
          }

          i++;
        }

        print('fav docs got');
      }else{
        print('inside else');

        print("institutionPref: " + Preferences.institutionPref);
        if(Preferences.institutionPref.toLowerCase() == "all"){
          snapshots = await FirebaseFirestore.instance
              .collection('Events')
              .get();
        }else{
          snapshots = await FirebaseFirestore.instance
              .collection('Events')
              .where('institutionID', isEqualTo: Preferences.institutionPref)
              .get();
        }


        print('working with snapshot......');
        snapshots.docs.forEach((element) {
          print("the element is now: " + element.id);
          Event event = Event.fromMap(element.data());
          value.forEach((elmnt) {
            if(elmnt.eventID == event.eventID){
              event.isFavourite = elmnt.isFavourite;
              event.tagID = elmnt.tagID;
            }
          });

          _eventList.add(event);
          print(event.mapPDF != null ? event.mapPDF : "event mapPDF null");
        });
        print('docs got');
      }

      print('done placing the events in list');
    });
  }catch(e){
    print("Something is wrong w/ database: " + e.toString());
  }
  Preferences.filteredEvents = _eventList;
  return _eventList;
}

Future<List> getFeaturedEvents(BuildContext context, EventNotifier eventNotifier) async{

  QuerySnapshot snapshots;
  List<Event> _eventList = [];

  await DatabaseService(uid: Preferences.uid).getEventFavourites().then((value) async {
    snapshots = await FirebaseFirestore.instance
        .collection('Events')
        .where('isPriority', isEqualTo: true)
        .get();

    snapshots.docs.forEach((element) {
      Event event = Event.fromMap(element.data());
      value.forEach((elmnt) {
        if (elmnt.eventID == event.eventID) {
          event.isFavourite = elmnt.isFavourite;
          event.tagID = elmnt.tagID;
        }
      });

      _eventList.add(event);
      print(event.mapPDF != null ? event.mapPDF : "event mapPDF null");
      print(_eventList.length);
    });
  });

  return _eventList;
}

Future<List> getEventsByCategory(BuildContext context, EventNotifier eventNotifier, String filterName) async{

  QuerySnapshot snapshots;

  List<Event> _eventList = [];
  print("context " + context.toString());
  try{
    if(context.toString().contains("FilterScreen") && filterName.trim().isNotEmpty){
      snapshots = await FirebaseFirestore.instance
          .collection('Events')
          .where("category", isEqualTo: filterName.trim())
          .get();

      snapshots.docs.forEach((element) {
        Event event = Event.fromMap(element.data());
        _eventList.add(event);
        print(event.category);
      });

      print('event list has '+_eventList.length.toString() + ' OBJECTS');
    }

    print('done placing the events in list');
  }catch(e){
    print(e);
  }

  eventNotifier.eventList = _eventList;
  print('returning list');
  return _eventList;
}