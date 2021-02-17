
import 'package:cut_gigs/models/Event.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static User currentUser;
  static String uid;
  static bool isAdmin;

  static String tagID;

  static String fcmToken;

  static List<Event> filteredEvents = <Event>[];

  static SharedPreferences preferences;

  static String institutionPref;

  //when user visits app for the first time
  static getVisitingFlag() async {
    preferences = await SharedPreferences.getInstance();
    bool alreadyVisited = preferences.getBool("alreadyVisited") ?? false;
    return alreadyVisited;
  }
  static setVisitedFlag() async {
    preferences = await SharedPreferences.getInstance();
    preferences.setBool("alreadyVisited", true);
  }

  //for the preferred institution the user prefers to receive notifications from
  static getInstitutionPref() async {
    preferences = await SharedPreferences.getInstance();
    bool institutionID = preferences.getBool("institutionID") ?? "none";
    return institutionID;
  }
  static setInstitutionPref(String institutionID) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setString("institutionID", institutionID);
  }

  //whether the user wants to receive notifications or not
  static Future<bool> getNotificationsFlag() async {
    preferences = await SharedPreferences.getInstance();
    bool notificationsFlag = preferences.getBool("notifications") ?? false;
    return notificationsFlag;
  }
  static setNotificationsFlag(bool switchStatus) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setBool("notifications", switchStatus);
  }
}