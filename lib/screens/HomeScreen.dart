import 'package:cut_gigs/config/styleguide.dart';
import 'package:cut_gigs/reusables/CategoryCard.dart';
import 'package:cut_gigs/reusables/CustomBottomNavBar.dart';
import 'package:cut_gigs/reusables/FeaturedEventsCard.dart';
import 'package:cut_gigs/reusables/SearchWidget.dart';
import 'package:cut_gigs/reusables/SideDrawer.dart';
import 'package:cut_gigs/reusables/UpcomingEventsCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKeyHome = new GlobalKey();

  //search bar variables
  final TextEditingController _searchController = new TextEditingController();
  String searchText ="";

  @override
  Widget build(BuildContext context) {
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
                        child: ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (BuildContext context, int index){
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child: eventCategoryCard(),
                            );
                          },
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
                      child: FeaturedEventsCard(),
                    ),//works like a carousel
                    SizedBox(height: 5.0,),
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: Text('Upcoming Events',style: pageHeadingTextStyle,),
                    ),
                    SizedBox(height: 5.0,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: 3,
                        itemBuilder: (BuildContext context, int index){
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 13.0),
                            child: UpcomingEventsCard(),
                          );
                        },
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
