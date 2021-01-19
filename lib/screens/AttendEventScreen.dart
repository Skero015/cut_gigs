import 'dart:io';
import 'package:cut_gigs/config/styleguide.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class AttendEventScreen extends StatefulWidget {
  @override
  _AttendEventScreenState createState() => _AttendEventScreenState();
}

class _AttendEventScreenState extends State<AttendEventScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKeyAttendEvent = new GlobalKey();
  String attendee;

  final TextEditingController _companyName = new TextEditingController();
  final TextEditingController _position = new TextEditingController();
  bool _isEnabled = false;

  String topicDropdownValue;
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      key: _scaffoldKeyAttendEvent,
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(
                30.0,
                55.0,
                25.0,
                25.0,
              ),
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 90.0),
                      child: Center(
                        child: Text(
                          'Attend Event',
                          style: pageHeadingTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'You are attending the event as a: ',
                          style: pageSubHeadingTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Radio(
                                value: 'Speaker',
                                groupValue: attendee,
                                onChanged: (value) {
                                  print(value);
                                  setState(() {
                                    this.attendee = value;
                                    _isEnabled = true;
                                  });
                                }),
                            Text(
                              'Speaker ',
                              style: pageSubHeadingTextStyle,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Radio(
                                value: 'Participant',
                                groupValue: attendee,
                                onChanged: (T) {
                                  print(T);
                                  setState(() {
                                    attendee = T;
                                    _isEnabled = false;
                                  });
                                }),
                            Text(
                              'Participant',
                              style: pageSubHeadingTextStyle,
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    CircleAvatar(
                      radius: 165.0,
                      backgroundColor: Colors.lightBlueAccent.shade50,
                      backgroundImage: _isEnabled //if isEnabled is equal to true, enable set profile picture, if false set disable button and set default profile picture
                          ? _imageFile == null
                              ? AssetImage('images/defaultprofilepicture.jpg')
                              : FileImage(File(_imageFile.path))
                          : AssetImage('images/defaultprofilepicture.jpg'),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 40.0,
                        ),
                        child: RaisedButton(
                          onPressed: _isEnabled
                              ? () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: ((builder) => bottomsheet()),
                                  );
                                }
                              : null,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          color: Colors.white70,
                          elevation: 50.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            //mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.camera_alt,
                                color: Color(0xFFAB1217),
                                size: 39,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Text(
                                  'Select Image',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      letterSpacing: 0.8),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 80.0, top: 40, right: 80),
                      child: DropdownButton<String>(
                        hint: Text('Topic'),
                        value: topicDropdownValue,
                        icon: Padding(
                          padding: const EdgeInsets.only(left: 375.0),
                          child: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.yellowAccent.shade700,
                            size: 39,
                          ),
                        ),
                        underline: Container(
                          height: 2,
                          color: _isEnabled ? Color(0xFF15AAD9) : Colors.grey,
                        ),
                        items: <String>[
                          'Technology',
                          'Engineering',
                          'Health',
                          'Agriculture',
                          'Finance',
                          'Construction',
                          'Energy'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: _isEnabled
                            ? (String newValue) {
                                setState(() {
                                  topicDropdownValue = newValue;
                                });
                              }
                            : null,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 80.0, top: 40, right: 80),
                      child: TextFormField(
                        enabled: _isEnabled,
                        autofocus: false,
                        controller: _companyName,
                        decoration: InputDecoration(
                          hintText: 'Company Name',
                          contentPadding:
                              EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black87),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF15AAD9)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF15AAD9)),
                          ),
                          errorBorder: UnderlineInputBorder(
                            //The line of the editText changes to red when the validator returns an error
                            borderSide: BorderSide(
                              color: Color(0xFFAB1217),
                            ),
                          ),
                        ),
                        style: GoogleFonts.poppins(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 80.0, top: 40, right: 80),
                      child: TextFormField(
                        enabled: _isEnabled,
                        autofocus: false,
                        controller: _position,
                        decoration: InputDecoration(
                          hintText: 'Position',
                          contentPadding:
                              EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black87),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF15AAD9)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF15AAD9)),
                          ),
                          errorBorder: UnderlineInputBorder(
                            //The line of the editText changes to red when the validator returns an error
                            borderSide: BorderSide(
                              color: Color(0xFFAB1217),
                            ),
                          ),
                        ),
                        style: GoogleFonts.poppins(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 60.0, left: 80, right: 80),
                        child: RaisedButton(
                          //Button comes with its own onTap or onPressed method .... I do not normally decorate buttons with Ink and Container widgets, I had to find a way to give it gradient colors since RaisedButton does not come with the decoration: field
                          onPressed: () {
                            //In this onPressed of the RaisedButton we will not need the setState method because
                            // we are not changing the state of the UI.
                            //We will only be this button to navigate to authenticate the user and move to a different screen
                          }, //Ink widget here, is a child of the Button, learning more about it however...
                          child: Ink(
                            //The Ink widget allowed us to decorate the button as we wish (we needed to use it for the color gradients) .
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(colors: <Color>[
                                Color(0xFF15AAD9),
                                Color(0xFF7EE0FF),
                              ]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child: Container(
                                constraints: const BoxConstraints(
                                    minWidth: 50.0, minHeight: 70),
                                alignment: Alignment.center,
                                child: Text(
                                  'Attend Event',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      letterSpacing: 0.8),
                                )),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 9.0,
                          padding: const EdgeInsets.all(0.0),
                        ),
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

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );

    setState(() {
      _imageFile = pickedFile;
    });
  }

  Widget bottomsheet() {
    return Container(
      height: 120.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 20.0,
      ),
      child: Column(
        children: <Widget>[
          Text(
            'Choose Profile photo',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                icon: Icon(
                  Icons.camera,
                  size: 50,
                ),
                label: Text(
                  'Camera',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              FlatButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                icon: Icon(
                  Icons.image,
                  size: 50,
                ),
                label: Text(
                  'Gallery',
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
