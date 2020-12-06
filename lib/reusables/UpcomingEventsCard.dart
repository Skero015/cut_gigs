import 'package:cut_gigs/config/styleguide.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpcomingEventsCard extends StatefulWidget {
  @override
  _UpcomingEventsCardState createState() => _UpcomingEventsCardState();
}

class _UpcomingEventsCardState extends State<UpcomingEventsCard> {

  bool isFavImgClicked = false;

  @override
  Widget build(BuildContext context) {

    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.all(Radius.circular(25.0),),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text('CUT Soccer Grounds',style: venueCardTextStyle,),
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
    );
  }
}
