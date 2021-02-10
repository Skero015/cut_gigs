import 'package:cut_gigs/config/preferences.dart';
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
import 'package:cut_gigs/services/notification_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{

  final GlobalKey<ScaffoldState> _scaffoldKeyHome = new GlobalKey();

  //search bar variables
  final TextEditingController _searchController = new TextEditingController();
  String searchText ="";
  AsyncSnapshot eventAsync;

  //tabBar controller
  TabController _tabController;

  Future getCategoryFuture;
  Future getEventsFuture;

  DateTime date, eventDate;

  EventNotifier eventNotifier;

  Stream eventChanges;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    initialiseLocalNotifications().whenComplete(() async{
    //await showNotification("Event Notification", "Your events have been refreshed", context);
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      eventNotifier = Provider.of<EventNotifier>(context, listen: false);

      bool visitingFlag = await Preferences.getVisitingFlag();
      //Preferences.setVisitedFlag();

      if(visitingFlag){

      }
    });

    getCategoryFuture = getCategories();

    _tabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();

    eventChanges.drain();
  }
  @override
  Widget build(BuildContext context) {

    date = DateTime.now();

    Stream streamer(String widgetName) {
      return eventChanges = Stream.fromFuture(getEvents(context, eventNotifier, widgetName));
    }

    //showNotification("Random Title", "random title", context);

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
                    Center(child: SearchWidget(context,_searchController, asyncSnapshot: eventAsync)),
                    SizedBox(height: 15.0,),
                    SizedBox(
                      height: 85,
                      child: Center(
                        child: FutureBuilder(
                          future: getCategoryFuture,
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            print(snapshot.connectionState.toString());
                            return snapshot.connectionState == ConnectionState.done  && snapshot.data != null ? ListView.builder(
                            primary: true,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 18.0),
                      child: StreamBuilder(
                        stream: streamer("Featured Events"),
                        builder: (context, snapshot) {
                          print("snapshot for featured events is now: " + snapshot.connectionState.toString());
                          print(snapshot.hasData);
                          return snapshot.connectionState == ConnectionState.done && snapshot.data != null ?
                          SizedBox(
                            height: 370,
                            width: double.infinity,
                            child: Swiper(
                                itemBuilder: (BuildContext context, int index){
                                  //print("event is featured: " + snapshot.data[index].isPriority.toString());
                                  return snapshot.data[index].isPriority ? FeaturedEventsCard(snapshot: snapshot, index: index, eventNotifier: eventNotifier,) : Container();
                                },
                              itemCount: Preferences.featuredEventsCount - 1,
                              pagination: null,
                              control: null,
                              autoplay: Preferences.featuredEventsCount > 1 ? true : false,
                              layout: SwiperLayout.STACK,
                              itemWidth: MediaQuery.of(context).size.width,
                              duration: 800,
                            ),
                          ) : Container();
                        }
                      ),
                    ),//works like a carousel
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
                      child: FutureBuilder(
                        initialData: [],
                        future: getEvents(context, eventNotifier, "Upcoming Events"),
                        builder: (context, snapshot) {
                          return snapshot.connectionState == ConnectionState.done && snapshot.data != null ?
                          SizedBox(
                            height: 600,
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                ListView.builder(
                                  primary: true,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (BuildContext context, int index){
                                    eventDate = DateTime.fromMillisecondsSinceEpoch(snapshot.data[index].date.millisecondsSinceEpoch);
                                    eventAsync = snapshot;
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 13.0),
                                      child: date.isBefore(eventDate) ? UpcomingEventsCard(snapshot: snapshot, index: index, eventNotifier: eventNotifier) : Container(),
                                    );
                                  },
                                ),
                                ListView.builder(
                                  primary: true,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (BuildContext context, int index){
                                    eventDate = DateTime.fromMillisecondsSinceEpoch(snapshot.data[index].date.millisecondsSinceEpoch);
                                    eventAsync = snapshot;
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

  Future initialiseLocalNotifications() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    try {
      // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
      var initializationSettingsAndroid = AndroidInitializationSettings(
          'mipmap/ic_launcher');
      var initializationSettingsIOS = IOSInitializationSettings(
        requestSoundPermission: false,
        requestBadgePermission: false,
        requestAlertPermission: false,
        onDidReceiveLocalNotification: PushService().onDidReceiveLocalNotification,
      );
      var initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS);
      await flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onSelectNotification: PushService().selectNotification);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> prepareNotification() async {

    await PushService.callOnFcmApiSendPushNotifications(title: "Sit tight.",body: "Your bev is being prepared for delivery.");

  }

  Future<void> showNotification(String title, String body,BuildContext context) async{

    await PushService().sendLocalNotification(title, body, context, flutterLocalNotificationsPlugin);

  }
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {

  //_HomeScreenState().prepareNotification();

  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

// Or do other work.
}
