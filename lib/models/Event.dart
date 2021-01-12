

import 'package:cloud_firestore/cloud_firestore.dart';

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
  String password;
  Map mapDetails;
  bool isPriority;
  bool isPrivate;

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
      this.password,
      this.mapDetails,
      this.isPriority,
      this.isPrivate);

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
    this.password = data['password'];
    this.mapDetails = data['mapDetails'];
    this.isPriority = data['isPriority'];
    this.isPrivate = data['isPrivate'];
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
      'location': location,
      'password': password,
      'mapDetails': mapDetails,
      'isPriority': isPriority,
      'isPrivate': isPrivate,
    };
  }
}

Future<List> getEvents() async{

  QuerySnapshot snapshots = await FirebaseFirestore.instance
      .collection('Events')
      .get();

  List<Event> _eventList = [];

  snapshots.docs.forEach((element) {

    Event event = Event.fromMap(element.data());
    _eventList.add(event);
  });

  return _eventList;
}