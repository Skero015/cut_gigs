import 'package:cut_gigs/config/preferences.dart';
import 'package:cut_gigs/config/styleguide.dart';
import 'package:cut_gigs/services/database_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:intl/intl.dart';

class UpcomingEventsCard extends StatefulWidget {

  AsyncSnapshot<dynamic> snapshot;
  int index;

  UpcomingEventsCard({this.snapshot, this.index});
  @override
  _UpcomingEventsCardState createState() => _UpcomingEventsCardState();
}

class _UpcomingEventsCardState extends State<UpcomingEventsCard> {

  bool isFavImgClicked = false;

  DateTime date;
  DateTime eventDate;
  DateFormat formatter;

  @override
  void initState() {
    super.initState();

    date = DateTime.now();
    formatter = DateFormat('dd-MM-yyyy hh:mm');
  }
  @override
  Widget build(BuildContext context) {

    eventDate = DateTime.fromMillisecondsSinceEpoch(widget.snapshot.data[widget.index].date);
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.all(Radius.circular(25.0),),
      child: FadeIn(
        duration: Duration(milliseconds: 400),
        curve: Curves.elasticIn,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              new BoxShadow(
                color: Colors.grey[800],
                offset: Offset(2.0, 7.0),
                blurRadius: 15.0,
              ),
              new BoxShadow(
                color: Colors.white,
                offset: Offset(0, -14),
                blurRadius: 15.0,
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(25.0),),
          ),
          child: Row(
            children: <Widget>[
              //image on the right
              ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0), bottomLeft: Radius.circular(25.0),),
                child: Image(
                  image: AssetImage('images/EventImage.png'),
                  height: 140,
                  width: 135,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.snapshot.data[widget.index].title,style: eventsCardTitleTextStyle,),
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
                              Text(formatter.format(eventDate.toLocal()).toString(),style: dateCardTextStyle,),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(widget.snapshot.data[widget.index].location,style: venueCardTextStyle,),
                            Padding(
                              padding: const EdgeInsets.only(left: 110.0),
                              child: GestureDetector(
                                child: Image(
                                  image: isFavImgClicked ? AssetImage('images/LikedEvent.png') : AssetImage('images/unLikeEvent.png'),
                                  height: 40,
                                  width: 40,
                                  fit: BoxFit.fitHeight,
                                ),
                                onTap: (){
                                  setState(() {
                                    isFavImgClicked ? isFavImgClicked = false : isFavImgClicked = true;

                                    if(isFavImgClicked){
                                      isFavImgClicked = false;
                                      DatabaseService(uid: Preferences.uid).updateEventFavourites(isFavImgClicked, widget.snapshot.data[widget.index].eventID);
                                    }else{
                                      isFavImgClicked = true;
                                      DatabaseService(uid: Preferences.uid).updateEventFavourites(isFavImgClicked, widget.snapshot.data[widget.index].eventID);
                                    }
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
