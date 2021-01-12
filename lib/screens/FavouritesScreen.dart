import 'package:cut_gigs/config/preferences.dart';
import 'package:cut_gigs/config/styleguide.dart';
import 'package:cut_gigs/models/Category.dart';
import 'package:cut_gigs/reusables/CategoryCard.dart';
import 'package:cut_gigs/reusables/SideDrawer.dart';
import 'package:cut_gigs/reusables/UpcomingEventsCard.dart';
import 'package:cut_gigs/services/database_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavouritesScreen extends StatefulWidget {
  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKeyFavourites = new GlobalKey();

  Future getCategoryFuture;
  @override
  void initState() {
    super.initState();

    getCategoryFuture = getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      key: _scaffoldKeyFavourites,
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      drawer: SideDrawer(),
      body: SafeArea(
          child: Flex(
            direction: Axis.vertical,
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
                        _scaffoldKeyFavourites.currentState.openDrawer();
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
                padding: const EdgeInsets.only(top: 90.0),
                child: Center(
                  child: Text('Favourites',style: pageHeadingTextStyle,textAlign: TextAlign.center,),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 45.0),
                    child: Text('Filter By',style: pageSubHeadingTextStyle,textAlign: TextAlign.right,),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 85,
                child: Center(
                  child: FutureBuilder(
                      future: getCategoryFuture,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        return ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index){
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child: eventCategoryCard(snapshot.data['image'], snapshot.data['name']),
                            );
                          },
                        );
                      }
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: StreamBuilder(
                  stream: Stream.fromFuture(DatabaseService(uid: Preferences.uid).getEventFavourites()),
                  builder: (context, snapshot) {
                    return ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index){
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 13.0),
                          child: UpcomingEventsCard(),
                        );
                      },
                    );
                  }
                ),
              ),
            ],
          )
      ),
    );
  }
}
