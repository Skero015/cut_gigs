
import 'package:cut_gigs/config/styleguide.dart';
import 'package:cut_gigs/screens/AttendEventScreen.dart';
import 'package:cut_gigs/screens/PdfScreen.dart';
import 'package:cut_gigs/screens/SpeakerDetailsScreens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';



class EventDetailsScreen extends StatefulWidget {
  @override
  _EventDetailsScreenState createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  Map<String, bool> dropdownClickedMap;
  bool isFavImgClicked = false;
  Future<void> launchUrl;
  String downloadedUrl;
  String pathPDF = "";
  bool _isLoading = true;

  PDFDocument scheduleDoc;
  final int scheduleFlag = 1;
  PDFDocument faqDoc;
  final int faqFlag = 2;

  final FirebaseStorage storage = FirebaseStorage.instance;

  //bool isDropDownClicked = false;

  @override
  void initState() {
    super.initState();

    dropdownClickedMap = {
      "About": false,
      "Speakers": false,
      "Event Schedule": false,
      "Survey": false,
      "Event FAQs": false,
      "Sponsors": false,
      "Event Organizers": false,
      "Map": false,
      "Event Meal Plan": false,
    };

    getFile('http://africau.edu/images/default/sample.pdf',scheduleFlag);
    getFile('https://firebasestorage.googleapis.com/v0/b/cut-gigs-30f0e.appspot.com/o/schedules%2FInternship_Advert%202021-2023.pdf?alt=media&token=f083e298-0d71-4384-9eb0-ab9a79880471',faqFlag);


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Container(
                  child: Image(
                    image: AssetImage('images/EventImage.png'),
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverFillRemaining(
                child: Container(
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50.0),
                            topRight: Radius.circular(50.0))),
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                              width: 500,
                              child: Text(
                                'Faculty of Engineering Graduation',
                                style: boldHeadingTextStyle,
                                softWrap: true,
                                textAlign: TextAlign.center,
                              )),
                          GestureDetector(
                            child: Image(
                              image: isFavImgClicked
                                  ? AssetImage('images/LikedEvent.png')
                                  : AssetImage('images/FavouriteYellow.png'),
                              height: 40,
                              width: 45,
                              fit: BoxFit.fitHeight,
                            ),
                            onTap: () {
                              setState(() {
                                isFavImgClicked
                                    ? isFavImgClicked = false
                                    : isFavImgClicked = true;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: eventSummary('images/DateIcon.png',
                            '29 May 2020', '12:00 - 18:00'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: eventSummary('images/LocationIcon.png',
                            'CUT Boet Troski Hall', 'Bloemfontein, Free State'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      dropdownMenuCard('About', 0),
                      dropdownClickedMap.values.elementAt(0) == true
                          ? Text(
                        'Some text that must show when you open About',
                        style: summarySubheadingTextStyle,
                      )
                          : Container(),
                      dropdownMenuCard('Speakers', 1),
                      dropdownClickedMap.values.elementAt(1) == true
                          ? SizedBox(
                        height: 180.0,
                        child: ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 6,
                          itemBuilder: (BuildContext context, int index) {
                            return SponsorSpeakerOrganizerCard(
                                'images/speaker1.png', 'speakerTag');
                          },
                        ),
                      )
                          : Container(),
                      dropdownMenuCard('Event Schedule', 2),
                      dropdownClickedMap.values.elementAt(2) == true
                          ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'To open the event schedule',
                            style: summarySubheadingTextStyle,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          RaisedButton(
                            onPressed: () =>
                            {

                              Navigator.of(context).push(MaterialPageRoute( builder: (context) => PdfScreen(scheduleDoc, _isLoading))),

                            },
                            child: Text(' Click Here ',
                                style: GoogleFonts.poppins(
                                    color: Colors.white)),
                            color: Colors.yellow[800],
                          )
                        ],
                      )
                          : Container(),
                      dropdownMenuCard('Survey', 3),
                      dropdownClickedMap.values.elementAt(3) == true
                          ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'To open the event survey',
                            style: summarySubheadingTextStyle,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          RaisedButton(
                            onPressed: () =>
                            {
                              launchUrl = SurveyURL('https://forms.gle/1MvTaGJYRAw33ZYS6')
                            },
                            child: Text(' Click Here ',
                                style: GoogleFonts.poppins(
                                    color: Colors.white)),
                            color: Colors.yellow[800],
                          )
                        ],
                      )
                          : Container(),
                      dropdownMenuCard('Event FAQs', 4),
                      dropdownClickedMap.values.elementAt(4) == true
                          ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'To open the event FAQs',
                            style: summarySubheadingTextStyle,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          RaisedButton(
                            onPressed: () =>
                            {
                              Navigator.of(context).push(MaterialPageRoute( builder: (context) => PdfScreen(faqDoc, _isLoading))),
                            },
                            child: Text(' Click Here ',
                                style: GoogleFonts.poppins(
                                    color: Colors.white)),
                            color: Colors.yellow[800],
                          )
                        ],
                      )
                          : Container(),
                      dropdownMenuCard('Sponsors', 5),
                      dropdownClickedMap.values.elementAt(5) == true
                          ? SizedBox(
                        height: 180.0,
                        child: ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 6,
                          itemBuilder: (BuildContext context, int index) {
                            return SponsorSpeakerOrganizerCard(
                                'images/sponsor1.png', "sponsorTag");
                          },
                        ),
                      )
                          : Container(),
                      dropdownMenuCard('Event Organizers', 6),
                      dropdownClickedMap.values.elementAt(6) == true
                          ? Column(
                        children: <Widget>[
                          Text(
                            'Some text that must show when you open About',
                            style: summarySubheadingTextStyle,
                          ),
                          SizedBox(
                            height: 180.0,
                            child: ListView.builder(
                              primary: false,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: 6,
                              itemBuilder:
                                  (BuildContext context, int index) {
                                return SponsorSpeakerOrganizerCard(
                                    'images/sponsor1.png',
                                    "organizerTag");
                              },
                            ),
                          )
                        ],
                      )
                          : Container(),
                      dropdownMenuCard('Map', 7),
                      dropdownMenuCard('Event Meal Plan', 8),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SafeArea(
            child: GestureDetector(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 45.0, horizontal: 20),
                child: Image(
                  image: AssetImage('images/BackBtn.png'),
                  height: 30,
                  fit: BoxFit.cover,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30.0, left: 80, right: 80),
              child: RaisedButton(
                //Button comes with its own onTap or onPressed method .... I do not normally decorate buttons with Ink and Container widgets, I had to find a way to give it gradient colors since RaisedButton does not come with the decoration: field
                onPressed: () {
                  //In this onPressed of the RaisedButton we will not need the setState method because
                  // we are not changing the state of the UI.
                  //We will only be this button to navigate to authenticate the user and move to a different screen
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AttendEventScreen()));
                },
                //Ink widget here, is a child of the Button, learning more about it however...
                child: Ink(
                  //The Ink widget allowed us to decorate the button as we wish (we needed to use it for the color gradients) .
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: <Color>[
                      Color(0xFF15AAD9),
                      Color(0xFF7EE0FF),
                    ]),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: Container(
                      constraints:
                      const BoxConstraints(minWidth: 50.0, minHeight: 70),
                      alignment: Alignment.center,
                      child: Text(
                        'Attend Event',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            letterSpacing: 0.8),
                      )),
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

  Widget eventSummary(String imgPath, String heading, String subHeading) {
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
              child: Image(
                image: AssetImage(imgPath),
                height: 38,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              heading,
              style: summaryHeadingTextStyle,
            ),
            Text(
              subHeading,
              style: summarySubheadingTextStyle,
            ),
          ],
        ),
      ],
    );
  }

  Widget dropdownMenuCard(String heading, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      child: GestureDetector(
        child: Container(
          decoration: ShapeDecoration(
            color: Color(0xFF2AB5E1).withOpacity(0.13),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  heading,
                  style: boldHeadingTextStyle,
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
              ),
              dropdownClickedMap.values.elementAt(index) == false
                  ? Icon(
                Icons.arrow_drop_down,
                color: Colors.yellow[800],
                size: 50,
              )
                  : Icon(
                Icons.arrow_drop_up,
                color: Colors.yellow[800],
                size: 50,
              ),
            ],
          ),
        ),
        onTap: () {
          setState(() {
            dropdownClickedMap.values.elementAt(index) == false
                ? dropdownClickedMap.update(heading, (existingValue) => true)
                : dropdownClickedMap.update(heading, (existingValue) => false);
          });
        },
      ),
    );
  }

  Widget SponsorSpeakerOrganizerCard(String imgPath, String tagID) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: GestureDetector(
        onTap: () =>
            Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => SpeakerDetailsScreen())),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              maxRadius: 52,
              backgroundColor: Color(0xFF9B1318),
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(50.0),
                ),
                child: Image(
                  image: AssetImage(imgPath),
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              'Cody Fisher',
              style: nameHeadingTextStyle,
            ),
            Text(
              'Vodacom',
              style: summarySubheadingTextStyle,
            ),
          ],
        ),
      ),
    );
  }

  void SpeakerInformation(BuildContext context, String tagID) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) =>
            Scaffold(
              body: Center(
                child: Hero(
                  tag: 'speaker_details_tag',
                  child: SpeakerDetailsScreen(),
                ),
              ),
            ),
      ),
    );
  }

  Future<void> SurveyURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void getFile(String url, int v) async {
    PDFDocument docs;
    if(v == 1)
      {
        scheduleDoc = await PDFDocument.fromURL(url,);
      }
    else if (v == 2)
      {
        faqDoc = await PDFDocument.fromURL(url,);
      }
    //downloadedUrl = url;
    setState(() {
      _isLoading = false;
    });
  }

  DownloadPdf(String filename) async {
    Reference folderReference = storage.ref().child('schedules');
    Reference fileReference = folderReference.child(filename);
    String url = await fileReference.getDownloadURL();

    setState(() {
      downloadedUrl = url;
    });
    //function call
  }
}
