import 'package:flutter/material.dart';

class SideDrawer extends StatefulWidget {
  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Image(
              image: AssetImage('images/MainBackground.png'),
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            SafeArea(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[

                      ],
                    ),
                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }
}

class SideDrawerCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(

    );
  }
}

