import 'dart:collection';

import 'package:cut_gigs/models/Event.dart';
import 'package:flutter/cupertino.dart';

class EventNotifier with ChangeNotifier {
  List<Event> _eventList = [];
  Event _currentEvent;
  bool isListenersNotified = false;

  UnmodifiableListView<Event> get eventList => UnmodifiableListView(_eventList);

  //gets the event that has been selected, this data can be used anywhere in the app
  Event get currentEvent => _currentEvent;

  set eventList(List<Event> eventList) {
    _eventList = eventList;

    notifyListeners();
  }

  set currentEvent(Event event) {
    _currentEvent = event;

    notifyListeners();
  }

}