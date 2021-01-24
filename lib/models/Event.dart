

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
  int date;
  String category;
  String faqs;
  String schedule;
  String hostID;
  String image;
  String institutionID;
  String location;
  String locationLatitude;
  String locationLongitude;
  String venue;
  String password;
  Map mapDetails;
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
      this.venue,
      this.password,
      this.mapDetails,
      this.isPriority,
      this.isPrivate,
      this.isFavourite);

  Event.fromMap(Map<String, dynamic> data){
    this.eventID = data['eventID'];
    this.title = data['title'];
    this.date = data['date'];
    this.about = data['about'];
    this.category = data['category'];
    this.faqs = data['faqs'];
    this.schedule = data['schedule'];
    this.hostID = data['hostID'];
    this.image = data['image'];
    this.institutionID = data['institutionID'];
    this.location = data['location'];
    this.locationLatitude = data['locationLatitude'];
    this.locationLongitude = data['locationLongitude'];
    this.venue = data['venue'];
    this.password = data['password'];
    this.mapDetails = data['mapDetails'];
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
      'category': category,
      'faqs': faqs,
      'schedule': schedule,
      'hostID': hostID,
      'image': image,
      'institutionID': institutionID,
      'venue': venue,
      'location' : location,
      'locationLongitude': locationLongitude,
      'locationLatitude': locationLatitude,
      'mapDetails': mapDetails,
      'password': password,
      'isPriority': isPriority,
      'isPrivate': isPrivate,
      'isFavourite' : isFavourite,
    };
  }
}

Future<List> getEvents(BuildContext context, EventNotifier eventNotifier, String widgetName) async{
  Firebase.initializeApp();
  QuerySnapshot snapshots;
  DocumentSnapshot docSnapshot;

  List<Event> _eventList = [];
  print("context " + context.toString());
  try{
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
          print(event.eventID);

          i++;
        }

        print('fav docs got');
      }else{
        print('inside else');
        snapshots = await FirebaseFirestore.instance
            .collection('Events')
            .get();

        snapshots.docs.forEach((element) {
          print(element.id);
          print(element.data());
          print(element.toString());
          Event event = Event.fromMap(element.data());
          print(event.eventID);
          event.isFavourite = value.singleWhere((elmnt) => elmnt.eventID == event.eventID).isFavourite;
          event.tagID = value.singleWhere((elmnt) => elmnt.eventID == event.eventID).tagID;
          _eventList.add(event);

          print(_eventList.length);
        });
        print('docs got');
      }

      print('done placing the events in list');
    });
  }catch(e){
    print(e);
  }

  // ignore: unnecessary_statements
  widgetName.contains('Upcoming') ? eventNotifier.eventList = _eventList : null;
  return _eventList;
}

Future<List> getEventsByCategory(BuildContext context, EventNotifier eventNotifier, String filterName) async{

  //QuerySnapshot snapshots;
  DocumentSnapshot docSnapshot;

  List<Event> _eventList = [];
  print("context " + context.toString());
  try{
    await DatabaseService(uid: Preferences.uid).getEventFavourites().then((value) async {

      if(context.toString().contains("FilterScreen") && filterName.isEmpty != true){
        print('inside if filter screen statement');

        int i = 0;

        while(i < value.length){
          docSnapshot = await FirebaseFirestore.instance
              .collection('Events')
              .doc(value[i].eventID)
              .get();

          Event event = Event.fromMap(docSnapshot.data());
          if(event.category == filterName)
          {
            _eventList.add(event);
          }
          print('event list has '+_eventList.length.toString() + ' OBJECTS');
          print(event.category);

          i++;
        }
        print('category docs got');
      }

      print('done placing the events in list');
    });
  }catch(e){
    print(e);
  }

  eventNotifier.eventList = _eventList;
  print('returning list');
  return _eventList;
}