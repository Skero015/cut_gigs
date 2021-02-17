import 'package:cached_network_image/cached_network_image.dart';
import 'package:cut_gigs/config/preferences.dart';
import 'package:cut_gigs/config/styleguide.dart';
import 'package:cut_gigs/models/Meal.dart';
import 'package:cut_gigs/models/Organiser.dart';
import 'package:cut_gigs/models/Speaker.dart';
import 'package:cut_gigs/models/Sponsor.dart';
import 'package:cut_gigs/notifiers/event_notifier.dart';
import 'package:cut_gigs/reusables/MapContainerWidget.dart';
import 'package:cut_gigs/screens/AttendEventScreen.dart';
import 'package:cut_gigs/screens/PdfScreen.dart';
import 'package:cut_gigs/screens/SpeakerDetailsScreens.dart';
import 'package:cut_gigs/screens/WebViewScreen.dart';
import 'package:cut_gigs/services/database_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';


class EventDetailsScreen extends StatefulWidget {

  bool isSubscribed;
  EventDetailsScreen({this.isSubscribed});
  @override
  _EventDetailsScreenState createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> with SingleTickerProviderStateMixin {

  final GlobalKey<ScaffoldState> _scaffoldKeyEventDetails = new GlobalKey<ScaffoldState>(debugLabel: '_scaffoldKeyEventDetails');

  Map<String, bool> dropdownClickedMap;
  bool isFavImgClicked = false;
  //bool isDropDownClicked = false;

  EventNotifier eventNotifier;

  DateTime eventDate;
  DateFormat formatter;

  Future getSponsorFuture;
  Future getSpeakerFuture;
  Future getOrganiserFuture;
  Future getMealFuture;

  Future<void> launchUrl;

  PDFDocument scheduleDoc;
  final int scheduleFlag = 1;
  PDFDocument faqDoc;
  PDFDocument mapDoc;
  PDFDocument mealDoc;
  final int faqFlag = 2;
  bool _isLoading = true;

  TabController _tabController;

  @override
  void initState() {
    super.initState();

    eventNotifier = Provider.of<EventNotifier>(context, listen: false);

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

    _tabController = new TabController(length: 2, vsync: this);
/*ClipRRect(
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(50.0),),
                    child: CachedNetworkImage(
                      imageUrl: eventNotifier.currentEvent.image,
                      fit: BoxFit.cover,
                    ),
                  ), */
    getFile(eventNotifier.currentEvent.schedule,scheduleFlag);
    getFile(eventNotifier.currentEvent.faqs,faqFlag);

    eventNotifier.currentEvent.isFavourite == true ? isFavImgClicked = true : isFavImgClicked = false;

    formatter = DateFormat.yMMMd('en_US');
    eventDate = DateTime.fromMillisecondsSinceEpoch(eventNotifier.currentEvent.date.millisecondsSinceEpoch);

    PDFDocument.fromURL(eventNotifier.currentEvent.mapPDF).then((value) {
      mapDoc = value;
    });
    PDFDocument.fromURL(eventNotifier.currentEvent.mealPDF).then((value) {
      mealDoc = value;
    });

    getSpeakerFuture = getSpeakers(eventNotifier.currentEvent.eventID);
    getSponsorFuture = getSponsors(eventNotifier.currentEvent.eventID);
    getOrganiserFuture = getOrganisers(eventNotifier.currentEvent.eventID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKeyEventDetails,
      body: Stack(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: eventNotifier.currentEvent.image,
            fit: BoxFit.cover,
            width: double.infinity,

          ),
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: DraggableScrollableSheet(
              minChildSize:  0.8,
                initialChildSize: 0.8,
                builder: (context, controller) {
                  return SingleChildScrollView(
                    controller: controller,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(35), topRight: Radius.circular(35)),
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                  width: 500,
                                  child: Text(eventNotifier.currentEvent.title,style: boldHeadingTextStyle,softWrap: true, textAlign: TextAlign.center,)
                              ),
                              GestureDetector(
                                child: Image(
                                  image: isFavImgClicked ? AssetImage('images/LikedEvent.png') : AssetImage('images/FavouriteYellow.png'),
                                  height: 40,
                                  width: 45,
                                  fit: BoxFit.fitHeight,
                                ),
                                onTap: ()async{
                                  setState(() {
                                    isFavImgClicked ? isFavImgClicked = false : isFavImgClicked = true;
                                  });

                                  await DatabaseService(uid: Preferences.uid).updateEventFavourites(isFavImgClicked, eventNotifier.currentEvent.eventID);
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 40,),
                          Padding(
                            padding: const EdgeInsets.only(left: 25.0),
                            child: eventSummary('images/DateIcon.png', formatter.format(eventDate), DateFormat('hh:mm a').format(eventDate) + " - "),
                          ),
                          SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsets.only(left: 25.0),
                            child: eventSummary('images/LocationIcon.png', eventNotifier.currentEvent.venue, eventNotifier.currentEvent.location),
                          ),
                          SizedBox(height: 20,),
                          dropdownMenuCard('About', 0),
                          dropdownClickedMap.values.elementAt(0) == true ? Padding(
                            padding: const EdgeInsets.only(left: 25.0),
                            child: Text(eventNotifier.currentEvent.about, style: summarySubheadingTextStyle,),
                          ) : Container(),
                          dropdownMenuCard('Speakers', 1),
                          dropdownClickedMap.values.elementAt(1) == true ? SizedBox(
                            height: 180.0,
                            child: FutureBuilder(
                                future: getSpeakerFuture,
                                builder: (context, snapshot) {
                                  return snapshot.connectionState == ConnectionState.done && snapshot.data != null ? ListView.builder(
                                    controller: controller,
                                    primary: false,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (BuildContext context, int index){
                                      return snapshot.data[index].isApproved ? SponsorSpeakerCard(snapshot, index) : Container();
                                    },
                                  ) : Container();
                                }
                            ),
                          ) : Container(),
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

                                  Navigator.of(context).push(MaterialPageRoute( builder: (context) => PdfScreen(scheduleDoc, _isLoading, 'Event Schedule'))),

                                },
                                child: Text(' Click Here ',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white)),
                                color: Colors.yellow[800],
                              )
                            ],
                          ) : Container(),
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
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => WebviewScreen(eventNotifier.currentEvent.survey)));
                                },
                                child: Text(' Click Here ',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white)),
                                color: Colors.yellow[800],
                              )
                            ],
                          ) : Container(),
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
                                  Navigator.of(context).push(MaterialPageRoute( builder: (context) => PdfScreen(faqDoc, _isLoading, 'Event FAQs'))),
                                },
                                child: Text(' Click Here ',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white)),
                                color: Colors.yellow[800],
                              )
                            ],
                          ) : Container(),
                          dropdownMenuCard('Sponsors', 5),
                          dropdownClickedMap.values.elementAt(5) == true ? SizedBox(
                            height: 180.0,
                            child: FutureBuilder(
                                future: getSponsorFuture,
                                builder: (context, snapshot) {
                                  return snapshot.connectionState == ConnectionState.done && snapshot.data != null ? ListView.builder(
                                    controller: controller,
                                    primary: false,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (BuildContext context, int index){
                                      return SponsorSpeakerCard(snapshot, index);
                                    },
                                  ) : Container();
                                }
                            ),
                          ) : Container(),
                          dropdownMenuCard('Event Organizers', 6),
                          dropdownClickedMap.values.elementAt(6) == true ? SizedBox(
                            height: 180.0,
                            child: FutureBuilder(
                                future: getOrganiserFuture,
                                builder: (context, snapshot) {
                                  return snapshot.connectionState == ConnectionState.done && snapshot.data != null ? ListView.builder(
                                    controller: controller,
                                    primary: false,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (BuildContext context, int index){
                                      return SponsorSpeakerCard(snapshot, index);
                                    },
                                  ) : Container();
                                }
                            ),
                          ) : Container(),
                          dropdownMenuCard('Map', 7),
                          dropdownClickedMap.values.elementAt(7) == true ? TabBar(
                            indicatorColor: Colors.yellow[800],
                            tabs: [
                              Tab(
                                icon: Text('Street Map',style: pageSubHeadingTextStyle,textAlign: TextAlign.center,),
                              ),
                              Tab(
                                icon: Text('Campus Map',style: pageSubHeadingTextStyle,textAlign: TextAlign.center,),
                              )
                            ],
                            controller: _tabController,
                            indicatorSize: TabBarIndicatorSize.tab,
                          ) : Container(),
                          dropdownClickedMap.values.elementAt(7) == true ?SizedBox(
                            height: 400,
                            width: MediaQuery.of(context).size.width - 50,
                            child: TabBarView(
                                controller: _tabController,
                                children: [
                                  eventNotifier.currentEvent.locationLongitude.trim().isNotEmpty ? MapContainer() : Container(),
                                  eventNotifier.currentEvent.mapPDF != null || eventNotifier.currentEvent.mapPDF.trim().isNotEmpty ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'To open the campus map',
                                        style: summarySubheadingTextStyle,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      RaisedButton(
                                        onPressed: () {

                                          Navigator.of(context).push(MaterialPageRoute( builder: (context) => PdfScreen(mapDoc, _isLoading, 'Campus Map')));

                                        },
                                        child: Text(' Click Here ',
                                            style: GoogleFonts.poppins(
                                                color: Colors.white)),
                                        color: Colors.yellow[800],
                                      )
                                    ],
                                  ) : Text('Map not available', style: summarySubheadingTextStyle,)
                                ]
                            ),
                          ) : Container(),
                          dropdownMenuCard('Event Meal Plan', 8),
                          dropdownClickedMap.values.elementAt(8) == true ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'To view the meal plan',
                                style: summarySubheadingTextStyle,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              RaisedButton(
                                onPressed: () =>
                                {
                                  Navigator.of(context).push(MaterialPageRoute( builder: (context) => PdfScreen(mealDoc, _isLoading, 'Meal Plan'))),
                                },
                                child: Text(' Click Here ',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white)),
                                color: Colors.yellow[800],
                              )
                            ],
                          ) : Container(),
                        ],
                      ),
                    ),
                  );
                },
            ),
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
          widget.isSubscribed == null ? Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30.0,left: 80, right: 80),
                child: RaisedButton(//Button comes with its own onTap or onPressed method .... I do not normally decorate buttons with Ink and Container widgets, I had to find a way to give it gradient colors since RaisedButton does not come with the decoration: field
                  onPressed: () {

                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AttendEventScreen()));

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
          ): Container(),
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
            Text(heading, style: summaryHeadingTextStyle, softWrap: true, overflow: TextOverflow.visible,),
            Text(subHeading, style: summarySubheadingTextStyle, softWrap: true, overflow: TextOverflow.ellipsis,),
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

  Widget SponsorSpeakerCard (AsyncSnapshot snapshot, int index) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: GestureDetector(
        onTap:() => snapshot.data[index].toString().contains('Speaker') ? Navigator.of(context).push(MaterialPageRoute(builder: (context) => SpeakerDetailsScreen(snapshot, index, tag: 'speaker_details_tag'+index.toString(),))): Navigator.of(context).push(MaterialPageRoute(builder: (context) => SpeakerDetailsScreen(snapshot, index, tag: 'sponsor_details_tag'+index.toString(),))),
        child: Column(
          children: <Widget>[
            Hero(
              tag: snapshot.data[index].toString().contains('Speaker') ? 'speaker_details_tag'+index.toString() : 'sponsor_details_tag'+index.toString(),
              child: CircleAvatar(
                maxRadius: 52,
                backgroundColor: Color(0xFF9B1318),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(50.0),),
                  child: snapshot.data[index].image.toString().trim().isNotEmpty ? CachedNetworkImage(
                    imageUrl: snapshot.data[index].image,
                    height: 100,
                    fit: BoxFit.cover,
                  ) : Image(image: AssetImage('images/defaultprofilepicture.jpg'), height: 350, fit: BoxFit.cover),
                ),
              ),
            ),
            Text(snapshot.data[index].toString().contains('Speaker') || snapshot.data[index].toString().contains('Organiser') ? snapshot.data[index].name : snapshot.data[index].title, style: nameHeadingTextStyle,),
            snapshot.data[index].toString().contains('Speaker') ? Text(snapshot.data[index].companyName, style: summarySubheadingTextStyle,) : Container(),
          ],
        ),
      ),
    );
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

}
