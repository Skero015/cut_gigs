import 'package:cut_gigs/config/styleguide.dart';
import 'package:cut_gigs/reusables/SideDrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyEventsScreen extends StatefulWidget {
  @override
  _MyEventsScreenState createState() => _MyEventsScreenState();
}

class _MyEventsScreenState extends State<MyEventsScreen> with SingleTickerProviderStateMixin {

  final GlobalKey<ScaffoldState> _scaffoldKeyMyEvents = new GlobalKey();

  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = new TabController(length: 2, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKeyMyEvents,
      drawer: SideDrawer(),
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
                                  child: Image(
                                    image: AssetImage('images/Drawer.png'),
                                    fit: BoxFit.cover,
                                    height: 35.0,
                                  ),
                                  onTap: () {
                                    _scaffoldKeyMyEvents.currentState.openDrawer();
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
                              child: Text('My Events',style: pageHeadingTextStyle,textAlign: TextAlign.center,),
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
                child: TabBarView(
                  children: [
                    ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: 6,
                      itemBuilder: (BuildContext context, int index){
                        return index == 0 ? Padding(
                          padding: const EdgeInsets.fromLTRB( 10.0, 42.0, 10.0 , 13.0),
                          child: eventSummaryCard(),
                        ) : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 13.0),
                          child: eventSummaryCard(),
                        );
                      },
                    ),
                    ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: 6,
                      itemBuilder: (BuildContext context, int index){
                        return index == 0 ? Padding(
                          padding: const EdgeInsets.fromLTRB( 10.0, 42.0, 10.0 , 13.0),
                          child: eventSummaryCard(),
                        ) : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 13.0),
                          child: eventSummaryCard(),
                        );
                      },
                    ),
                  ],
                  controller: _tabController,
                ),
              ),
            ],
          ),
      ),
    );
  }
}

Widget eventSummaryCard(){


  return Container(
    child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Row(
            children: <Widget>[
              //image on the right
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(25.0),),
                child: Image(
                  image: AssetImage('images/EventImage.png'),
                  height: 140,
                  width: 140,
                  fit: BoxFit.cover,
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Varsity Cup: CUT vs UOFS',style: eventsCardTitleTextStyle,),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Image(
                                image: AssetImage('images/DateIcon.png'),
                                height: 25,
                                width: 20,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width: 10,),
                              Text('17 August 2020',style: dateCardTextStyle,),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.0,),
                    Row(
                      children: <Widget>[
                        Image(
                          image: AssetImage('images/LocationIcon.png'),
                          height: 25,
                          width: 20,
                          fit: BoxFit.fitHeight,
                        ),
                        SizedBox(width: 10,),
                        Text('CUT Soccer Grounds',style: venueCardTextStyle,),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 10,),
        Divider(thickness: 0.5, color: Colors.black),
      ],
    ),
  );
}
