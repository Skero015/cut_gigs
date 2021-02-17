import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_gigs/config/styleguide.dart';
import 'package:cut_gigs/notifiers/event_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ScannerScreen extends StatefulWidget {
  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKeyScanner = new GlobalKey();

  String _tagID;
  String _attendeeID;

  EventNotifier eventNotifier;

  @override
  void initState() {
    super.initState();

    eventNotifier = Provider.of<EventNotifier>(context, listen: false);

    scanQR().then((value) => {
      FirebaseFirestore.instance.collection('Tags').doc(_tagID).get().then((value) {
        _attendeeID = value['attendeeID'];
        FirebaseFirestore.instance.collection('Events').doc(eventNotifier.currentEvent.eventID).collection('Attendees').doc(_attendeeID).update({
          'hasAttended' : true,
        });
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKeyScanner,
      body: SafeArea(
          child: Column(
            children: [
              Material(
                elevation: 5.0,
                child: Container(
                  color: Colors.white,
                  height: 359,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: -70,
                        top: -25,
                        child: Image(
                          image: AssetImage('images/background_images/TopCornerLighter.png'),
                          height: 415,
                          width: 415,
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30.0, 55.0, 25.0, 25.0,),
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
                          Padding(
                            padding: const EdgeInsets.only(top: 40.0),
                            child: Center(
                              child: Text( 'Scan',style: pageHeadingTextStyle,textAlign: TextAlign.center,),
                            ),
                          ),
                          SizedBox(height: 40,),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Text( 'Scan',style: pageHeadingTextStyle,textAlign: TextAlign.center,),
                  Text( 'Scan',style: pageHeadingTextStyle,textAlign: TextAlign.center,),
                ],
              ),
              Row(
                children: [
                  Text( 'Scan',style: pageHeadingTextStyle,textAlign: TextAlign.center,),
                  Text( 'Scan',style: pageHeadingTextStyle,textAlign: TextAlign.center,),
                ],
              ),
            ],
          )
      ),
    );
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _tagID = barcodeScanRes;
    });
  }
}
