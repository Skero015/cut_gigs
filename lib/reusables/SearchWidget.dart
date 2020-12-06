import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const TextStyle dropDownLabelStyle =
TextStyle(color: Colors.white, fontSize: 16.0);
const TextStyle dropDownMenuItemStyle =
TextStyle(color: Colors.black, fontSize: 16.0);

// ignore: non_constant_identifier_names
Widget SearchBar(BuildContext context, TextEditingController searchController ,{Function(dynamic) initiateSearch}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 40.0),
    child: Material(
      elevation: 0.0,
      borderRadius: BorderRadius.all(
        Radius.circular(20.0),
      ),
      //shape: ,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.yellow[800]),
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: TextFormField(
            onChanged: (text) {

              initiateSearch(searchController.text);
            },
            enabled: true,
            autovalidate: false,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            controller:  searchController,
            style: dropDownMenuItemStyle,
            cursorColor: Colors.blue,
            decoration: InputDecoration(
              hintText: 'Find Events...',
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 32.0, vertical: 25.0),
              prefixIcon: InkWell(
                onTap: () {

                },
                child: new Image(image: AssetImage('images/SearchEventsIcon.png'),height: 10.0,width: 10.0,),
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    ),
  );
}
