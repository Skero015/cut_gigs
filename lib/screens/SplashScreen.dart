import 'package:cloud_functions/cloud_functions.dart';
import 'package:cut_gigs/config/preferences.dart';
import 'package:cut_gigs/reusables/CustomBottomNavBar.dart';
import 'package:cut_gigs/screens/auth_screens/LoginScreen.dart';
import 'package:cut_gigs/services/notification_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
    'getUserId',
  );

@override
  void initState() {

  SystemChannels.textInput.invokeMethod('TextInput.hide');

    Future.delayed(Duration(milliseconds: 2700), () async {
      try{
        PushService().initialisePushService(context).whenComplete(() {
          print('done initializing push notifications');
        });
      }catch(e){
        print("Heyyyyy" + e.toString());
      }

      Navigator.of(context).pop();

      if(Preferences.currentUser == null){
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) =>
            new LoginScreen()));
      }else{
        print(Preferences.currentUser.uid);
        print(Preferences.currentUser.displayName);
        print(Preferences.currentUser.phoneNumber);
        print(Preferences.currentUser.email);
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) =>
            new CustomNavBar(index: 1,)));
      }

    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Image(fit: BoxFit.cover,
        image: AssetImage('images/SplashScreen.jpg'),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
