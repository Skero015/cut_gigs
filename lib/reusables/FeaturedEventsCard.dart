import 'package:cached_network_image/cached_network_image.dart';
import 'package:cut_gigs/config/preferences.dart';
import 'package:cut_gigs/config/styleguide.dart';
import 'package:cut_gigs/screens/EventDetailsScreen.dart';
import 'package:cut_gigs/screens/MyEventsScreen.dart';
import 'package:cut_gigs/services/database_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeaturedEventsCard extends StatefulWidget {

  AsyncSnapshot<dynamic> snapshot;
  int index;
  BuildContext context;

  FeaturedEventsCard({this.snapshot, this.index, this.context});

  @override
  _FeaturedEventsCardState createState() => _FeaturedEventsCardState();
}

class _FeaturedEventsCardState extends State<FeaturedEventsCard> {

  bool isFavImgClicked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF9B1318),
        boxShadow: [
          new BoxShadow(
            color: Colors.grey[800],
            offset: Offset(2.0, 7.0),
            blurRadius: 15.0,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(30.0),),
      ),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(22.0),),
            child: GestureDetector(
              child: CachedNetworkImage(
                imageUrl: widget.snapshot.data[widget.index].image,
                height: 240,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => EventDetailsScreen()));
              },
            ),
          ),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.yellow[700],
                        borderRadius: BorderRadius.all(Radius.circular(15.0),),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5),
                        child: Column(
                          children: <Widget>[
                            Text('29',style: featuredCardDateTextStyle,),
                            Text('MAY',style: featuredCardDateTextStyle,),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(widget.snapshot.data[widget.index].title,style: featuredCardTitleTextStyle, overflow: TextOverflow.ellipsis),
                        Row(
                          children: <Widget>[
                            Text(widget.snapshot.data[widget.index].location,style: featuredCardVenueTextStyle,),
                            Padding(
                              padding: const EdgeInsets.only(left: 170.0),
                              child: GestureDetector(
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

                                  await DatabaseService(uid: Preferences.uid).updateEventFavourites(isFavImgClicked, widget.snapshot.data[widget.index].eventID);

                                  print(isFavImgClicked);
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 25,)
                      ],
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
