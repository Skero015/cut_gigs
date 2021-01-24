import 'package:cut_gigs/screens/MapScreen.dart';
import "package:latlong/latlong.dart" as latLng;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class MapContainer extends StatefulWidget {
  @override
  _MapContainerState createState() => _MapContainerState();
}

class _MapContainerState extends State<MapContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: MediaQuery.of(context).size.width - 50,
      child: FlutterMap(
          options: MapOptions(
            onTap: (latLng.LatLng coordinates){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => MapScreen(latLng.LatLng(-29.120665401122718, 26.21291623068287))));
            },
            center: latLng.LatLng(-29.120665401122718, 26.21291623068287),
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
                width: 130.0,
                height: 130.0,
                point: latLng.LatLng(-29.120665401122718, 26.21291623068287),
                builder: (ctx) =>
                new Container(
                  child: Icon(Icons.location_on, color: Colors.blue, size: 60,),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
