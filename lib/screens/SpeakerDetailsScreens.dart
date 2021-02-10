import 'package:cached_network_image/cached_network_image.dart';
import 'package:cut_gigs/config/styleguide.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SpeakerDetailsScreen extends StatefulWidget {

  final AsyncSnapshot snapshot;
  final int index;
  final String tag;
  SpeakerDetailsScreen(this.snapshot, this.index, {this.tag});

  @override
  _SpeakerDetailsScreenState createState() => _SpeakerDetailsScreenState();
}

class _SpeakerDetailsScreenState extends State<SpeakerDetailsScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKeySDetails = new GlobalKey<ScaffoldState>(debugLabel: '_scaffoldKeySDetails');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKeySDetails,
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Hero(
        tag: widget.tag,
        child: Stack(
          children: <Widget>[
            Image(
              image: AssetImage('images/EditSpeakerAdminScreen.png'),
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
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Image(
                            image: AssetImage('images/AppBar.png'),
                            fit: BoxFit.cover,
                            height: 75.0,
                          ),
                        ],
                      ),
                    ),
                    Expanded(child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 0, bottom: 30),
                          child: Center(
                            child: Text(
                              widget.snapshot.data[widget.index].toString().contains('Speaker') ? 'Speaker' :
                              widget.snapshot.data[widget.index].toString().contains('Sponsor') ? 'Sponsor':'Organiser',
                              style: pageHeadingTextStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),

                        Center(
                          child: CircleAvatar(
                            radius: 180.0,
                            backgroundColor: Colors.lightBlueAccent.withOpacity(0.5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(170.0),),
                              child: widget.snapshot.data[widget.index].image.toString().trim().isNotEmpty ? CachedNetworkImage(
                                imageUrl: widget.snapshot.data[widget.index].image,
                                height: 350,
                                fit: BoxFit.cover
                              ) : Image(image: AssetImage('images/defaultprofilepicture.jpg'), height: 350, fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Center(
                          child: Column(
                            children: <Widget>[
                              Text(widget.snapshot.data[widget.index].toString().contains('Speaker') ? widget.snapshot.data[widget.index].name :
                              widget.snapshot.data[widget.index].toString().contains('Sponsor') ? widget.snapshot.data[widget.index].title : widget.snapshot.data[widget.index].name, style: nameHeadingTextStyle,),
                              widget.snapshot.data[widget.index].toString().contains('Speaker') ? Text(widget.snapshot.data[widget.index].companyName, style: summarySubheadingTextStyle,) : Container(),
                            ],
                          ),
                        ),

                        widget.snapshot.data[widget.index].toString().contains('Speaker') ? Padding(
                          padding: const EdgeInsets.only(top: 30.0, bottom: 20.0, left: 30),
                          child: speakerSummary(Icons.business_center_outlined,'Job Title' ,widget.snapshot.data[widget.index].position),
                        ) : Container(),
                        widget.snapshot.data[widget.index].toString().contains('Speaker') ? Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 20.0, left: 30),
                          child: speakerSummary(Icons.mic,'Topic' ,widget.snapshot.data[widget.index].topic),
                        ) : Container(),
                        widget.snapshot.data[widget.index].toString().contains('Speaker') ? Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 20.0, left: 30),
                          child: speakerSummary(Icons.mail_outline, 'Email Address',widget.snapshot.data[widget.index].email),
                        ) : Container(),
                        /*widget.snapshot.data[widget.index].toString().contains('Speaker') ? Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 20.0, left: 30),
                          child: speakerSummary(Icons.location_on_outlined, 'Address','Bloemfontein, Free State'),
                        ) : Container(),*/
                        widget.snapshot.data[widget.index].toString().contains('Organiser') ? Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 20.0, left: 30),
                          child: speakerSummary(Icons.message_outlined, 'Message',widget.snapshot.data[widget.index].message),
                        ) : Container(),
                      ],
                    ),
                    ),
                    ),
                  ],
                ),),
          ],
        ),
      ),
    );
  }

  Widget speakerSummary(IconData iconName , String heading, String subHeading) {

    return Row(
      children: <Widget>[
        Material(
          elevation: 8,
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
          child: CircleAvatar(
            maxRadius: 30,
            backgroundColor: Color(0xFF9B1318),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Icon(
                iconName,
                size: 38,
                color: Colors.yellowAccent.shade700,
              ),
            ),
          ),
        ),
        SizedBox(width: 15,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(heading, style: summaryHeadingTextStyle,softWrap: true,),
              Text(subHeading, style: summarySubheadingTextStyle, softWrap: true,),
            ],
          ),
        ),
      ],
    );
  }

}
