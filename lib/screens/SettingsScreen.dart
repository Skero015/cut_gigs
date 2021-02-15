import 'package:cut_gigs/config/preferences.dart';
import 'package:cut_gigs/config/styleguide.dart';
import 'package:cut_gigs/models/Institution.dart';
import 'package:cut_gigs/notifiers/institution_notifier.dart';
import 'package:cut_gigs/screens/auth_screens/LoginScreen.dart';
import 'package:cut_gigs/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with SingleTickerProviderStateMixin{

  Auth auth;
  String institutionDropdownValue = "";
  InstitutionNotifier institutionNotifier;
  List<DropdownMenuItem<String>> institutionDropdownList;
  bool switchStatus = false;

  void addInstitutionList() async{
    institutionNotifier.institutionList.forEach((element) {
      if(!institutionDropdownList.contains(element.id))
      institutionDropdownList.add(new DropdownMenuItem(child: Text(element.name), value: element.id));
    });
  }

  @override
  void initState() {
    super.initState();
    institutionDropdownList = [];
    Preferences.getNotificationsFlag().then((value) {
      switchStatus = value;
    });

    institutionNotifier = Provider.of<InstitutionNotifier>(context, listen: false);
    addInstitutionList();
    print("switch status: " + switchStatus.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image(
            image: AssetImage('images/EditSpeakerAdminScreen.png'),
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,// gives you height of the device
            width: MediaQuery.of(context).size.width,// gives you width of the device
          ),
          SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(35.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                        GestureDetector(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black,
                                size: 39,
                              ),
                              Text('Back',
                                  style: GoogleFonts.poppins(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      letterSpacing: 0.8)),
                            ],
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),

                        Image(
                          image: AssetImage('images/AppBar.png'),
                          fit: BoxFit.cover,
                          height: 75.0,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40,),
                  Center(
                    child: Text('Settings',style: pageHeadingTextStyle,textAlign: TextAlign.center,),
                  ),
                  SizedBox(height: 60,),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Receive Notifications',style:  GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w500, letterSpacing: 0.9),textAlign: TextAlign.center,),
                        FlutterSwitch(
                          width: 125.0,
                          height: 45.0,
                          valueFontSize: 20.0,
                          toggleSize: 35.0,
                          value: switchStatus,
                          borderRadius: 30.0,
                          padding: 8.0,
                          showOnOff: true,
                          onToggle: (val) {
                            setState(() {
                              switchStatus = val;
                              Preferences.setNotificationsFlag(switchStatus);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text('Institution',style:  GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w500, letterSpacing: 0.9),textAlign: TextAlign.center,),
                        ),
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: institutionDropdownValue.trim().isNotEmpty ? institutionDropdownValue : null,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                              size: 60,
                            ),
                            items: institutionDropdownList.toList(),
                            onTap: (){
                              print(institutionDropdownList.first.value);
                            },
                            onChanged: (String newValue) {
                              setState(() {
                                institutionDropdownValue = newValue;

                                if(institutionDropdownValue.trim() != "All"){
                                  institutionNotifier.currentInstitution = institutionNotifier.institutionList.singleWhere((element) => element.id == newValue);
                                  Preferences.setInstitutionPref(institutionNotifier.currentInstitution.id);
                                }else{
                                  Preferences.setInstitutionPref("All");
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30.0,left: 80, right: 80),
              child: RaisedButton(//Button comes with its own onTap or onPressed method .... I do not normally decorate buttons with Ink and Container widgets, I had to find a way to give it gradient colors since RaisedButton does not come with the decoration: field
                onPressed: () async{

                  Navigator.of(context).pop();
                  await auth.signOut().then((value) {
                    print('success');

                  }).catchError((onError){
                    print(onError);
                  });
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new LoginScreen()));
                },//Ink widget here, is a child of the Button, learning more about it however...
                child: Ink(//The Ink widget allowed us to decorate the button as we wish (we needed to use it for the color gradients) .
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFF15AAD9),
                          Color(0xFFAB1217),
                        ]
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: Container(
                      constraints: const BoxConstraints(minWidth: 50.0, minHeight: 70),
                      alignment: Alignment.center,
                      child: Text('Sign Out',textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.white, letterSpacing: 0.8),)),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 9.0,
                padding: const EdgeInsets.all(0.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
