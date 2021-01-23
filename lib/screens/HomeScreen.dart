import 'package:cut_gigs/config/styleguide.dart';
import 'package:cut_gigs/models/Category.dart';
import 'package:cut_gigs/models/Event.dart';
import 'package:cut_gigs/notifiers/event_notifier.dart';
import 'package:cut_gigs/reusables/CategoryCard.dart';
import 'package:cut_gigs/reusables/CustomBottomNavBar.dart';
import 'package:cut_gigs/reusables/FeaturedEventsCard.dart';
import 'package:cut_gigs/reusables/SearchWidget.dart';
import 'package:cut_gigs/reusables/SideDrawer.dart';
import 'package:cut_gigs/reusables/UpcomingEventsCard.dart';
import 'package:cut_gigs/services/database_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{

  final GlobalKey<ScaffoldState> _scaffoldKeyHome = new GlobalKey();

  //search bar variables
  final TextEditingController _searchController = new TextEditingController();
  String searchText ="";

  //tabBar controller
  TabController _tabController;

  Future getCategoryFuture;

  DateTime date, eventDate;

  EventNotifier eventNotifier;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      eventNotifier = Provider.of<EventNotifier>(context, listen: false);
    });
    Firebase.initializeApp();
    getCategoryFuture = getCategories();

    _tabController = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {

    date = DateTime.now();

    return Scaffold(
      backgroundColor: Colors.transparent,
      key: _scaffoldKeyHome,
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      drawer: SideDrawer(),
      body: SafeArea(
        child: Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.start,
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
                      _scaffoldKeyHome.currentState.openDrawer();
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(child: SearchBar(context,_searchController)),
                    SizedBox(height: 15.0,),
                    SizedBox(
                      height: 85,
                      child: Center(
                        child: FutureBuilder(
                          future: getCategoryFuture,
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            print(snapshot.connectionState.toString());
                            return snapshot.connectionState == ConnectionState.done  && snapshot.data != null ? ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index){
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                child: eventCategoryCard(snapshot.data[index].image, snapshot.data[index].name, context),
                              );
                            },
                          ) : Container();
                          }
                        ),
                      ),
                    ),
                    SizedBox(height: 15.0,),
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: Text('Featured Events',style: boldHeadingTextStyle),
                    ),
                    /*Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 18.0),
                      child: FeaturedEventsCard(snapshot: snapshot, index: index,),
                    ),*/ //works like a carousel
                    SizedBox(height: 5.0,),
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
                    SizedBox(height: 5.0,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: StreamBuilder(
                        initialData: [],
                        stream: Stream.fromFuture(getEvents(context, eventNotifier)),
                        builder: (context, snapshot) {
                          return snapshot.connectionState == ConnectionState.done && snapshot.data != null ?
                          SizedBox(
                            height: 600,
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                ListView.builder(
                                  primary: false,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (BuildContext context, int index){
                                    eventDate = DateTime.fromMillisecondsSinceEpoch(snapshot.data[index].date);
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 13.0),
                                      child: date.isBefore(eventDate) ? UpcomingEventsCard(snapshot: snapshot, index: index, eventNotifier: eventNotifier) : Container(),
                                    );
                                  },
                                ),
                                ListView.builder(
                                  primary: false,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (BuildContext context, int index){
                                    eventDate = DateTime.fromMillisecondsSinceEpoch(snapshot.data[index].date);
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 13.0),
                                      child: date.isAfter(eventDate) ? UpcomingEventsCard(snapshot: snapshot, index: index, eventNotifier: eventNotifier) : Container(),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ) : Container();
                        }
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
