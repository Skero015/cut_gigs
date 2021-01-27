import 'dart:io';

import 'package:cut_gigs/config/preferences.dart';
import 'package:cut_gigs/config/styleguide.dart';
import 'package:cut_gigs/screens/WebViewScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SideDrawer extends StatefulWidget {
  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 125,
      child: new Drawer(
        child: Stack(
          children: <Widget>[
            Positioned(
              left: -75,
              top: -10,
              child: Image(
                image: AssetImage('images/background_images/DrawerTopCorner.png'),
                height: 450,
                width: 450,
              ),
            ),
            SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 85.0, left: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Hello, \n' + Preferences.currentUser.displayName + "!", style: pageHeadingTextStyle,),
                          GestureDetector(
                            child: Image(
                              image: AssetImage('images/drawer_icons/CancelIcon.png'),
                              fit: BoxFit.fill,
                              height: 50.0,
                              width: 50.0,
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          SizedBox(width: 5,)
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Text(Preferences.currentUser.email, style: sdEmailTextStyle,),
                    ),
                    SizedBox(height: 15,),
                    /*Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Text('0762630001', style: sdNumberTextStyle,),
                    ),*/
                    SizedBox(height: 120,),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: SideDrawerCategory('Edit Profile','images/drawer_icons/EditIcon.png'),
                    ),
                    SizedBox(height: 16,),
                    Divider(thickness: 0.5, color: Colors.black, indent: 5, endIndent: 10,),
                    SizedBox(height: 53,),
                    /*Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: SideDrawerCategory('Calendar','images/DateIcon.png'),
                    ),
                    Divider(thickness: 0.5, color: Colors.black, indent: 5, endIndent: 10,),
                    SizedBox(height: 52,),*/
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: SideDrawerCategory('Help','images/drawer_icons/HelpIcon.png'),
                    ),
                    Divider(thickness: 0.5, color: Colors.black, indent: 5, endIndent: 10,),
                    SizedBox(height: 53,),
                    /*Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: SideDrawerCategory('Host Login','images/drawer_icons/LoginIcon.png'),
                    ),*/
                    //Divider(thickness: 0.5, color: Colors.black, indent: 5, endIndent: 10,),

                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }
}

class SideDrawerCategory extends StatelessWidget {

  String title = "", imagePath = "";
  SideDrawerCategory(this.title, this.imagePath);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: new Text(title, style: sdHeadingTextStyle,),
      leading: Image(image: AssetImage(imagePath.trim()), height: 35, width: 35,),
      onTap: () async{
        Navigator.of(context).pop();
        switch(title) {
          case 'Edit Profile':
            /*Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new EditProfileScreen()));*/
            break;
          case "Calendar":
          /*Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new EditProfileScreen()));*/
            break;
          case "Help":
            const url = 'https://www.cut.ac.za/contact-us';
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => WebviewScreen(url)));
            break;
          case "Host Login":
          /*Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new EditProfileScreen()));*/
            break;
        }
      },
    );
  }
}

