
import 'package:cut_gigs/models/Event.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Preferences {
  static User currentUser;
  static String uid;

  static String tagID;

  static String fcmToken;

  static int featuredEventsCount = 0;

  static List<Event> filteredEvents = <Event>[];
}