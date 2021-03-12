import 'package:cloud_functions/cloud_functions.dart';
import 'package:cut_gigs/config/preferences.dart';
import 'package:cut_gigs/models/Preferences.dart';
import 'package:cut_gigs/reusables/CustomBottomNavBar.dart';
import 'package:cut_gigs/screens/auth_screens/LoginScreen.dart';
import 'package:cut_gigs/services/database_services.dart';
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

    Future.delayed(Duration(milliseconds: 3100), () async {
      try{
        PushService().initialisePushService(context);
      }catch(e){
        print("Heyyyyy" + e.toString());
      }

      if(Preferences.currentUser == null){
        Navigator.of(context).pop();
      Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) =>
      new LoginScreen()));
      }else{
        await getPreferences().then((value) {
          Preference institutionElement;
          institutionElement = value.firstWhere((element) => element.type == "Institution");
          Preferences.institutionPref = institutionElement.preference;
        }).then((value){

          DatabaseService(uid: Preferences.uid).getPriveledgeBool();
          Navigator.of(context).pop();
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) =>
              new CustomNavBar(index: 1,)));
        });

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
