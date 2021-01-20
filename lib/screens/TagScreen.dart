import 'package:cut_gigs/config/styleguide.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'EventDetailsScreen.dart';



class TagScreen extends StatefulWidget {
  @override
  _TagScreenState createState() => _TagScreenState();
}

class _TagScreenState extends State<TagScreen> {

  String qrCodeTag = 'Ticket No: 123454 Belongs to Mr KK Mei seat no G88' ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      //resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          Image(
            image: AssetImage('images/MainBackground.png'),
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,// gives you height of the device
            width: MediaQuery.of(context).size.width,// gives you width of the device
          ),
          SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(35.0),
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
                          height: 75.0,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 0, bottom: 30),
                          child: Center(
                            child: Text(
                              'Event Tag',
                              style: pageHeadingTextStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:40, right: 40),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.only(topLeft:Radius.circular(22.0),topRight:Radius.circular(22.0)),
                                  child: GestureDetector(
                                    child: Image(
                                      image: AssetImage('images/EventImage.png'),
                                      height: 237,
                                      //width: 580,
                                      fit: BoxFit.cover,
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => EventDetailsScreen()));
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30.0, bottom: 40, left: 40),
                                  child: Text('Varsity Cup: CUT vs UOFS',style: pageSubHeadingTextStyle,textAlign: TextAlign.start,),
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 40),
                                      child: Text('Date',style: categoryCardTextStyle),
                                    ),
                                    SizedBox(width: 200,),
                                    Text('Time',style: categoryCardTextStyle),
                                  ],
                                ),
                                //SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 40),
                                      child: Text('17 August 2020',style: categoryCardTextStyle),
                                    ),
                                    SizedBox(width: 110,),
                                    Text('15:00',style: categoryCardTextStyle),
                                  ],
                                ),

                                SizedBox(height: 20,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 40),
                                  child: Text('Place',style: categoryCardTextStyle,textAlign: TextAlign.start,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 40),
                                  child: Text('CUT Sports Grounds',style: categoryCardTextStyle,textAlign: TextAlign.start,),
                                ),
                                SizedBox(height: 25,),
                                Divider(
                                  height: 20,
                                thickness: 3,),
                                SizedBox(height: 25,),
                                Center(
                                  child: QrImage(
                                    data: qrCodeTag,
                                    size: 350.0,
                                  ),
                                ),
                                SizedBox(height: 50,),

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),),
                ],
              ),
          ),

        ],
      ),
    );
  }

}
