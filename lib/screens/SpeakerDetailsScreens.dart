import 'package:cut_gigs/config/styleguide.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SpeakerDetailsScreen extends StatefulWidget {
  @override
  _SpeakerDetailsScreenState createState() => _SpeakerDetailsScreenState();
}

class _SpeakerDetailsScreenState extends State<SpeakerDetailsScreen> {

  final GlobalKey<FormState> _formKeyLogin = GlobalKey<FormState>(debugLabel: '_LoginScreenState');
  final GlobalKey<ScaffoldState> _scaffoldKeyLogin = new GlobalKey<ScaffoldState>(debugLabel: '_LoginScreenState');

  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          Image(
            image: AssetImage('images/EditSpeakerAdminScreen.png'),
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,// gives you height of the device
            width: MediaQuery.of(context).size.width,// gives you width of the device
          ),
          SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(35.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Image(
                          image: AssetImage('images/AppBar.png'),
                          fit: BoxFit.cover,
                          height: 75.0,
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 0, bottom: 30),
                        child: Center(
                          child: Text(
                            'Speaker',
                            style: pageHeadingTextStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),

                      Center(
                        child: CircleAvatar(
                          radius: 165.0,
                          backgroundColor: Colors.lightBlueAccent.shade50,
                          backgroundImage: AssetImage('images/speaker1.png'),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Center(
                        child: Column(
                          children: <Widget>[
                            Text('Cody Fisher', style: nameHeadingTextStyle,),
                            Text('Vodacom', style: summarySubheadingTextStyle,),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 30.0, bottom: 20.0, left: 30),
                        child: speakerSummary(Icons.business_center_outlined,'Job Title' ,'Programmer'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 20.0, left: 30),
                        child: speakerSummary(Icons.mic,'Topic' ,'AI in programming'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 20.0, left: 30),
                        child: speakerSummary(Icons.mail_outline, 'Email Address','abc@gmail.com'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 20.0, left: 30),
                        child: speakerSummary(Icons.location_on_outlined, 'Address','Bloemfontein, Free State'),
                      ),

                    ],
                  ),
                  ),
                  ),
                ],
              ),),
        ],
      ),
    );
  }

  Widget speakerSummary(IconData iconName , String heading, String subHeading) {

    return Row(
      children: <Widget>[
        Material(
          elevation: 8,
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
          child: CircleAvatar(
            maxRadius: 30,
            backgroundColor: Color(0xFF9B1318),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Icon(
                iconName,
                size: 38,
                color: Colors.yellowAccent.shade700,
              ),
            ),
          ),
        ),
        SizedBox(width: 15,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(heading, style: summaryHeadingTextStyle,),
            Text(subHeading, style: summarySubheadingTextStyle,),
          ],
        ),
      ],
    );
  }

}
