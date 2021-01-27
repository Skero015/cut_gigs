import 'package:cut_gigs/config/styleguide.dart';
import 'package:cut_gigs/models/Event.dart';
import 'package:cut_gigs/notifiers/event_notifier.dart';
import 'package:cut_gigs/reusables/EventSummaryCard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'EventDetailsScreen.dart';

class FilterScreen extends StatefulWidget {

  String filterName;
  FilterScreen(this.filterName);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}


class _FilterScreenState extends State<FilterScreen> with SingleTickerProviderStateMixin {

  final GlobalKey<ScaffoldState> _scaffoldKeyMyEvents = new GlobalKey();

  TabController _tabController;
  EventNotifier eventNotifier;
  Future<List> futureList;

  DateTime date, eventDate;



  @override
  void initState() {
    super.initState();

    eventNotifier = Provider.of<EventNotifier>(context, listen: false);
    //futureList = getEvents(context, eventNotifier);
    Firebase.initializeApp();
    _tabController = new TabController(length: 2, vsync: this);
  }
  @override
  Widget build(BuildContext context) {

    date = DateTime.now();


    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKeyMyEvents,
      //drawer: SideDrawer(),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Material(
              elevation: 5.0,
              child: Container(
                color: Colors.white,
                height: 359,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: -70,
                      top: -25,
                      child: Image(
                        image: AssetImage('images/background_images/TopCornerLighter.png'),
                        height: 415,
                        width: 415,
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30.0, 55.0, 25.0, 25.0,),
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
                                height: 90.0,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40.0),
                          child: Center(
                            child: Text( widget.filterName + ' events',style: pageHeadingTextStyle,textAlign: TextAlign.center,),
                          ),
                        ),
                        SizedBox(height: 40,),
                        TabBar(
                          indicatorColor: Colors.yellow[800],
                          tabs: [
                            Tab(
                              icon: Text('Upcoming',style: pageSubHeadingTextStyle,textAlign: TextAlign.center,),
                            ),
                            Tab(
                              icon: Text('Past',style: pageSubHeadingTextStyle,textAlign: TextAlign.center,),
                            )
                          ],
                          controller: _tabController,
                          indicatorSize: TabBarIndicatorSize.tab,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder(
                initialData: [],
                stream: Stream.fromFuture(getEventsByCategory(context, eventNotifier, widget.filterName)),
                builder: (context,snapshot){
                  return snapshot.connectionState == ConnectionState.done && snapshot.data != null? SizedBox(
                    child:TabBarView(
                      controller: _tabController,
                      children: [
                        ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index){
                            eventDate = DateTime.fromMillisecondsSinceEpoch(snapshot.data[index].date.millisecondsSinceEpoch);
                            return index == 0 ? Padding(
                              padding: const EdgeInsets.fromLTRB( 10.0, 42.0, 10.0 , 13.0),
                              child:date.isBefore(eventDate)? EventSummaryCard(context: context, snapshot: snapshot, index: index, eventNotifier: eventNotifier,) : Container(),
                            ) : Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 13.0),
                              child: date.isBefore(eventDate)?  EventSummaryCard(context: context, snapshot: snapshot, index: index, eventNotifier: eventNotifier,) : Container(),
                            );
                          },
                        ),
                        ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index){
                            return index == 0 ? Padding(
                              padding: const EdgeInsets.fromLTRB( 10.0, 42.0, 10.0 , 13.0),
                              child:date.isAfter(eventDate)?  EventSummaryCard(context: context, snapshot: snapshot, index: index, eventNotifier: eventNotifier,) : Container(),
                            ) : Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 13.0),
                              child:date.isAfter(eventDate)?  EventSummaryCard(context: context, snapshot: snapshot, index: index, eventNotifier: eventNotifier,) : Container(),
                            );
                          },
                        ),
                      ],
                    ),
                  ): Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
