import 'package:cached_network_image/cached_network_image.dart';
import 'package:cut_gigs/config/preferences.dart';
import 'package:cut_gigs/config/styleguide.dart';
import 'package:cut_gigs/models/Event.dart';
import 'package:cut_gigs/notifiers/event_notifier.dart';
import 'package:cut_gigs/reusables/Dialogs.dart';
import 'package:cut_gigs/screens/EventDetailsScreen.dart';
import 'package:cut_gigs/screens/MyEventsScreen.dart';
import 'package:cut_gigs/services/database_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FeaturedEventsCard extends StatefulWidget {

  AsyncSnapshot<dynamic> snapshot;
  int index;
  BuildContext context;
  EventNotifier eventNotifier;

  FeaturedEventsCard({this.snapshot, this.index, this.context, this.eventNotifier});

  @override
  _FeaturedEventsCardState createState() => _FeaturedEventsCardState();
}

class _FeaturedEventsCardState extends State<FeaturedEventsCard> {

  bool isFavImgClicked = false;

  DateTime eventDate;

  @override
  void initState() {
    super.initState();

    eventDate = DateTime.fromMillisecondsSinceEpoch(widget.snapshot.data[widget.index].date);
    widget.snapshot.data[widget.index].isFavourite == true ? isFavImgClicked = true : isFavImgClicked = false;
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(widget.snapshot.data[widget.index].password.toString());
        widget.eventNotifier.currentEvent = widget.snapshot.data[widget.index];
        print(widget.eventNotifier.currentEvent.eventID + " selected");

        if(widget.snapshot.data[widget.index].password.toString().trim().isNotEmpty){

          showDialog(context: context,
              builder: (BuildContext context){
                return CommunicationDialogBox(
                  title: "Enter Event Password",
                  snapshot: widget.snapshot,
                  index: widget.index,
                  buttonText: "Continue",
                );
              }
          );

        }else{

          Navigator.of(context).push(MaterialPageRoute(builder: (context) => EventDetailsScreen()));
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF9B1318),
          borderRadius: BorderRadius.all(Radius.circular(30.0),),
        ),
        child: Column(
          children: <Widget>[
            ClipRRect(
              clipper: null,
              borderRadius: BorderRadius.all(Radius.circular(35.0),),
              child: CachedNetworkImage(
                imageUrl: widget.snapshot.data[widget.index].image,
                height: 240,
                width: double.infinity,
                fit: BoxFit.cover,
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
                              Text(DateFormat.d('en-US').format(eventDate),style: featuredCardDateTextStyle,),
                              Text(DateFormat.MMM('en-US').format(eventDate),style: featuredCardDateTextStyle,),
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(widget.snapshot.data[widget.index].location,style: featuredCardVenueTextStyle,),
                              SizedBox(width: 50,),
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

                                  await DatabaseService(uid: Preferences.uid).updateEventFavourites(isFavImgClicked, widget.snapshot.data[widget.index].eventID).whenComplete(() async {

                                    await getEvents(widget.context, widget.eventNotifier, "Upcoming");
                                  });

                                  print(isFavImgClicked);
                                },
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
      ),
    );
  }
}
