import 'package:cut_gigs/reusables/CustomBottomNavBar.dart';
import 'package:cut_gigs/screens/AttendEventScreen.dart';
import 'package:cut_gigs/screens/HomeScreen.dart';
import 'package:cut_gigs/screens/SpeakerDetailsScreens.dart';
import 'package:cut_gigs/screens/SplashScreen.dart';
import 'package:cut_gigs/screens/TagScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

void main() async => {

  WidgetsFlutterBinding.ensureInitialized(),

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp,DeviceOrientation.portraitDown])
      .then((_) => runApp(MyApp()),
  )
};

class MyApp extends StatelessWidget {

  // This widget is the root of your application.

  Map<String, dynamic> myMap = Map<String, dynamic> () ;
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget),
          maxWidth: 1200,
          minWidth: 250,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.autoScaleDown(300, name: MOBILE,scaleFactor: 0.90),
            ResponsiveBreakpoint.autoScaleDown(450, name: MOBILE,scaleFactor: 0.90),
            //ResponsiveBreakpoint.autoScaleDown(450.1, name: MOBILE,scaleFactor: 1),
            ResponsiveBreakpoint.autoScaleDown(600, name: TABLET, scaleFactor: 0.90),
            ResponsiveBreakpoint.autoScaleDown(800, name: TABLET, scaleFactor: 0.90),
            ResponsiveBreakpoint.autoScaleDown(1000, name: TABLET,scaleFactor: 0.90),
            ResponsiveBreakpoint.autoScaleDown(1200, name: DESKTOP, scaleFactor: 1.35),
            ResponsiveBreakpoint.autoScaleDown(1600, name: DESKTOP, scaleFactor: 1.30),
            ResponsiveBreakpoint.autoScale(2460, name: "4K",scaleFactor: 1.90),
          ],
          background: Image(
            image: AssetImage('images/MainBackground.png'),
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
      ),
      title: 'CUT Gigs',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
      home: CustomNavBar(),
     // home: TagScreen(),
      //home: AttendEventScreen(),
      //home: SpeakerDetailsScreen(),
    );
  }
}
