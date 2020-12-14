import 'package:cut_gigs/config/styleguide.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';

class EventDetailsScreen extends StatefulWidget {
  @override
  _EventDetailsScreenState createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {

  Map<String, bool> dropdownClickedMap;
  bool isFavImgClicked = false;
  //bool isDropDownClicked = false;

  @override
  void initState() {
    super.initState();

    dropdownClickedMap = {
      "About" : false,
      "Speakers" : false,
      "Event Schedule" : false,
      "Survey" : false,
      "Event FAQs" : false,
      "Sponsors" : false,
      "Event Organizers" : false,
      "Map" : false,
      "Event Meal Plan" : false,
    };
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
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(50.0), topRight: Radius.circular(50.0))),
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                              width: 500,
                              child: Text('Faculty of Engineering Graduation',style: boldHeadingTextStyle,softWrap: true, textAlign: TextAlign.center,)
                          ),
                          GestureDetector(
                            child: Image(
                              image: isFavImgClicked ? AssetImage('images/LikedEvent.png') : AssetImage('images/FavouriteYellow.png'),
                              height: 40,
                              width: 45,
                              fit: BoxFit.fitHeight,
                            ),
                            onTap: (){
                              setState(() {
                                isFavImgClicked ? isFavImgClicked = false : isFavImgClicked = true;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 40,),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: eventSummary('images/DateIcon.png', '29 May 2020', '12:00 - 18:00'),
                      ),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: eventSummary('images/LocationIcon.png', 'CUT Boet Troski Hall', 'Bloemfontein, Free State'),
                      ),
                      SizedBox(height: 20,),
                      dropdownMenuCard('About', 0),
                      dropdownClickedMap.values.elementAt(0) == true ? Text('Some text that must show when you open About', style: summarySubheadingTextStyle,) : Container(),
                      dropdownMenuCard('Speakers', 1),
                      dropdownClickedMap.values.elementAt(1) == true ? SizedBox(
                        height: 180.0,
                        child: ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 6,
                          itemBuilder: (BuildContext context, int index){
                            return SponsorSpeakerCard('images/speaker1.png');
                          },
                        ),
                      ) : Container(),
                      dropdownMenuCard('Event Schedule', 2),
                      dropdownMenuCard('Survey', 3),
                      dropdownMenuCard('Event FAQs', 4),
                      dropdownMenuCard('Sponsors', 5),
                      dropdownClickedMap.values.elementAt(5) == true ? SizedBox(
                        height: 180.0,
                        child: ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 6,
                          itemBuilder: (BuildContext context, int index){
                            return SponsorSpeakerCard('images/sponsor1.png',);
                          },
                        ),
                      ) : Container(),
                      dropdownMenuCard('Event Organizers', 6),
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
                padding: const EdgeInsets.symmetric(vertical: 45.0, horizontal: 20),
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
                padding: const EdgeInsets.only(bottom: 30.0,left: 80, right: 80),
                child: RaisedButton(//Button comes with its own onTap or onPressed method .... I do not normally decorate buttons with Ink and Container widgets, I had to find a way to give it gradient colors since RaisedButton does not come with the decoration: field
                  onPressed: () {

                    //In this onPressed of the RaisedButton we will not need the setState method because
                    // we are not changing the state of the UI.
                    //We will only be this button to navigate to authenticate the user and move to a different screen

                  },//Ink widget here, is a child of the Button, learning more about it however...
                  child: Ink(//The Ink widget allowed us to decorate the button as we wish (we needed to use it for the color gradients) .
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: <Color>[
                            Color(0xFF15AAD9),
                            Color(0xFF7EE0FF),
                          ]
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Container(
                        constraints: const BoxConstraints(minWidth: 50.0, minHeight: 70),
                        alignment: Alignment.center,
                        child: Text('Attend Event',textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.white, letterSpacing: 0.8),)),
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

  Widget eventSummary(String imgPath , String heading, String subHeading) {

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

  Widget dropdownMenuCard (String heading, int index) {

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
                child: Text(heading,style: boldHeadingTextStyle,softWrap: true, textAlign: TextAlign.center,),
              ),
              dropdownClickedMap.values.elementAt(index) == false ? Icon(Icons.arrow_drop_down, color: Colors.yellow[800], size: 50,) : Icon(Icons.arrow_drop_up, color: Colors.yellow[800], size: 50,),
            ],
          ),
        ),
        onTap: () {

          setState(() {
            dropdownClickedMap.values.elementAt(index) == false ? dropdownClickedMap.update(heading, (existingValue) => true) : dropdownClickedMap.update(heading, (existingValue) => false);
          });
        },
      ),
    );
  }

  Widget SponsorSpeakerCard (String imgPath) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: Column(
        children: <Widget>[
          CircleAvatar(
            maxRadius: 52,
            backgroundColor: Color(0xFF9B1318),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(50.0),),
              child: Image(
                image: AssetImage(imgPath),
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text('Cody Fisher', style: nameHeadingTextStyle,),
          Text('Vodacom', style: summarySubheadingTextStyle,),
        ],
      ),
    );
  }
}
