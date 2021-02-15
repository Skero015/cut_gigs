import 'package:cached_network_image/cached_network_image.dart';
import 'package:cut_gigs/config/preferences.dart';
import 'package:cut_gigs/config/styleguide.dart';
import 'package:cut_gigs/models/Event.dart';
import 'package:cut_gigs/notifiers/event_notifier.dart';
import 'package:cut_gigs/reusables/SideDrawer.dart';
import 'package:cut_gigs/reusables/UpcomingEventsCard.dart';
import 'package:cut_gigs/screens/TagScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class SearchScreen extends StatefulWidget {

  AsyncSnapshot snapshot;
  SearchScreen({this.snapshot});
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with SingleTickerProviderStateMixin {

  final GlobalKey<ScaffoldState> _scaffoldKeySearchScreen = new GlobalKey();

  //search bar variables
  final TextEditingController _searchController = new TextEditingController();
  String searchText = "";

  TabController _tabController;

  EventNotifier eventNotifier;

  DateTime eventDate, date;

  List<Event> filteredList;

  @override
  void initState() {
    super.initState();
    eventNotifier = Provider.of<EventNotifier>(context, listen: false);

    _tabController = new TabController(length: 2, vsync: this);

    filteredList = [];
    filteredList.addAll(Preferences.filteredEvents);
  }

  @override
  Widget build(BuildContext context) {

    date = DateTime.now().toLocal();

    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKeySearchScreen,
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
                        image: AssetImage(
                            'images/background_images/TopCornerLighter.png'),
                        height: 415,
                        width: 415,
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            30.0, 55.0, 25.0, 25.0,),
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
                        Material(
                          elevation: 0.0,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                          //shape: ,
                          child: Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width - 80,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.yellow[800]),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextFormField(
                                onChanged: (text) {
                                  setState(() {
                                    print(_searchController.text);
                                    filterSearchResults(text);
                                  });
                                },

                                enabled: true,
                                autovalidate: false,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                controller: _searchController,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 25.0),
                                cursorColor: Colors.blue,
                                decoration: InputDecoration(
                                  hintText: 'Search Event',
                                  filled: false,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 32.0, vertical: 10.0),
                                  prefixIconConstraints: BoxConstraints(
                                      minWidth: 10, minHeight: 10),
                                  prefixIcon: InkWell(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 15.0),
                                      child: new Image(image: AssetImage(
                                          'images/SearchEventsIcon.png'),
                                        height: 35.0,
                                        width: 35.0,
                                        fit: BoxFit.scaleDown,),
                                    ),
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            FutureBuilder(
              initialData: filteredList,
              future: null,
              builder: (context, snapshot) {
                return Expanded(
                  child: ListView.builder(
                    primary: true,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: filteredList.length,
                    itemBuilder: (BuildContext context, int index) {
                      eventDate = DateTime.fromMillisecondsSinceEpoch(filteredList[index].date.millisecondsSinceEpoch).toLocal();
                      if(date.isBefore(eventDate)){
                        return _searchController.text.trim().isNotEmpty ? Padding(
                          padding: const EdgeInsets.only(top: 20.0, left: 10, right: 10),
                          child: UpcomingEventsCard(snapshot: snapshot, index: index, eventNotifier: eventNotifier),
                        ) : Container();//eventSummaryCard(context, snapshot, index, eventNotifier);
                      }else{
                        return Container();
                      }
                    },
                  ),
                );
              }
            ),
          ],
        ),
      ),
    );
  }

  void filterSearchResults(String queryTitle) {
    if(queryTitle.isNotEmpty) {
      List<Event> dummyListData = [];

      dummyListData = Preferences.filteredEvents.where((element) => element.title.trim().toLowerCase().contains(queryTitle.trim().toLowerCase())).toList();
      setState(() {
        filteredList.clear();
        filteredList.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        filteredList.clear();
      });
    }

  }
}