import 'package:cut_gigs/config/styleguide.dart';
import 'package:cut_gigs/notifiers/event_notifier.dart';
import 'package:cut_gigs/screens/EventDetailsScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';


class EventSummaryCard extends StatefulWidget {

  AsyncSnapshot<dynamic> snapshot;
  int index;
  BuildContext context;
  EventNotifier eventNotifier;

  EventSummaryCard({this.context,this.snapshot, this.index, this.eventNotifier});
  @override
  _EventSummaryCardState createState() => _EventSummaryCardState();
}

class _EventSummaryCardState extends State<EventSummaryCard> {

  bool isFavImgClicked = false;

  DateTime date;
  DateTime eventDate;
  DateFormat formatter;


  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    date = DateTime.now();
    formatter = DateFormat('dd-MM-yyyy hh:mm');

    widget.snapshot.data[widget.index].isFavourite == true ? isFavImgClicked = true : isFavImgClicked = false;
  }

  @override
  Widget build(BuildContext context) {

    eventDate = DateTime.fromMillisecondsSinceEpoch(widget.snapshot.data[widget.index].date.millisecondsSinceEpoch);

    return Container(
      child: GestureDetector(
        onTap:() {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => EventDetailsScreen()));
        },
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
                      image: NetworkImage(widget.snapshot.data[widget.index].image),
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
                            Text(widget.snapshot.data[widget.index].venue ,style: venueCardTextStyle,),
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
      ),
    );
  }
}