

import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

import 'package:cut_gigs/config/preferences.dart';
import 'package:cut_gigs/screens/HomeScreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushService {

  final FirebaseMessaging fcm = FirebaseMessaging();

  Future initialise() async {

    if(Platform.isIOS)
    {

      fcm.requestNotificationPermissions(IosNotificationSettings(sound: false, badge: true, alert: true));
    }else{

    }

    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    var initializationSettingsAndroid = AndroidInitializationSettings('logo');
    var initializationSettingsIOS = IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);


    fcm.configure(
      //when app is in foreground and we receive a push notification
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
      },
      onBackgroundMessage: Platform.isIOS ? null : myBackgroundMessageHandler,
      //when app is closed completely and its opened from push notification
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
      },
      //when app is in background and its opened from push notification
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
      },
    );

    fcm.getToken().then((String token) {

      //assert(token != null);
      Preferences.fcmToken = token;

      if(token != null){
//save token
        var tokenRef = FirebaseFirestore.instance.collection('Users')
            .doc(Preferences.uid)
            .collection('Tokens')
            .doc(token);

        tokenRef.set({
          'token' : token,
          'createdAt' : FieldValue.serverTimestamp(),
          'platform' : Platform.operatingSystem,
        });
      }
      print('fcm push notification token: '+ token);
    });
  }

  Future onDidReceiveLocalNotification(int id, String title, String body, String payLoad) async {

    //somewhere should go here
  }

  Future<void> localNotification (String title, String body, BuildContext context) async {

    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =  FlutterLocalNotificationsPlugin();

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'channel id: $title', 'channel name: $title', 'channel description: $body',
        importance: Importance.max, priority: Priority.high, ticker: 'ticker');

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
        0, '$title', '$body', platformChannelSpecifics);

  }

  Future selectNotification(String payload) async {
    if (payload != null) {
      print('notification payload: ' + payload);
    }

    /*await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SecondScreen(payload)),
    );*/
  }

  static Future<bool> callOnFcmApiSendPushNotifications({List <String> userToken, String title, String body}) async {

    final postUrl = 'https://fcm.googleapis.com/fcm/send';
    final data = {
      //"registration_ids" : userToken,

      "collapse_key" : "type_a",
      "notification" : {
        "title": title,
        "body" : body,
        "image" : ""
      },
      "priority": "high",
      "data": {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "id": "1",
        "status": "done"
      },
      "to" : Preferences.fcmToken,
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization': 'key=' // 'key=YOUR_SERVER_KEY'
    };

    final response = await http.post(
        postUrl,
        body: json.encode(data),
        encoding: Encoding.getByName('utf-8'),
        headers: headers);

    if (response.statusCode == 200) {
      // on success do sth
      print('test ok push CFM');
      return true;
    } else {
      print(' CFM error');
      // on failure do sth
      return false;
    }
  }

}