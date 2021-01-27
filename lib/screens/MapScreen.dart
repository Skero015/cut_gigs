import 'package:cut_gigs/notifiers/event_notifier.dart';
import "package:latlong/latlong.dart" as latLng;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {

  MapScreen();
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  EventNotifier eventNotifier;

  @override
  void initState() {
    super.initState();

    eventNotifier = Provider.of<EventNotifier>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: FlutterMap(
            options: MapOptions(
              center: latLng.LatLng(double.parse(eventNotifier.currentEvent.locationLatitude), double.parse(eventNotifier.currentEvent.locationLongitude)),
              zoom: 17.0,
            ),
            layers: [
              new TileLayerOptions(
                  urlTemplate: "https://api.mapbox.com/styles/v1/osamgroupt/ckkb1fppb0ka617po0rs8bwvb/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoib3NhbWdyb3VwdCIsImEiOiJja2tiMTg1MmowMzNvMm9vY2doMGtzbnhwIn0.XDT7nISGMo0vz9ucfogaQA",
                  additionalOptions: {
                    'accessToken' : 'pk.eyJ1Ijoib3NhbWdyb3VwdCIsImEiOiJja2tiMWUwbmwwYTBkMnZveGR2ZHFpYWR2In0.dDwtxTLW30iEvIGvUC5skQ',
                    'id' : 'mapbox.mapbox-streets-v8'
                  }
              ),
              new MarkerLayerOptions(
                markers: [
                  new Marker(
                    width: 100.0,
                    height: 100.0,
                    point: latLng.LatLng(double.parse(eventNotifier.currentEvent.locationLatitude), double.parse(eventNotifier.currentEvent.locationLongitude)),
                    builder: (ctx) =>
                    new Container(
                      child: Icon(Icons.location_on, color: Colors.blue,size: 60,),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
