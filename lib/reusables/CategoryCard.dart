import 'package:cached_network_image/cached_network_image.dart';
import 'package:cut_gigs/config/styleguide.dart';
import 'package:cut_gigs/screens/EventDetailsScreen.dart';
import 'package:cut_gigs/screens/FilterScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget eventCategoryCard(String image, String filterName, BuildContext context){
  return Material(
    elevation: 5.0,
    borderRadius: BorderRadius.all(Radius.circular(15.0),),
    child: GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.yellow[800]),
          borderRadius: BorderRadius.all(Radius.circular(15.0),),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: <Widget>[
                CachedNetworkImage(
                    imageUrl: image,
                    height: 50,
                    fit: BoxFit.cover
                ),
                Center(child: Text(filterName,style: categoryCardTextStyle)),
              ],
            ),
          ),
        ),
      ),
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => FilterScreen(filterName)));
      },
    ),
  );
}