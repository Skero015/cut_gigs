import 'package:cut_gigs/screens/auth_screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

@override
  void initState() {

  SystemChannels.textInput.invokeMethod('TextInput.hide');

    Future.delayed(Duration(milliseconds: 2700), () async {
      Navigator.of(context).pop();
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) =>
          new LoginScreen()));
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
