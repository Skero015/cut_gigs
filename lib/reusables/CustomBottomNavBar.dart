import 'package:cut_gigs/screens/FavouritesScreen.dart';
import 'package:cut_gigs/screens/HomeScreen.dart';
import 'package:cut_gigs/screens/MyEventsScreen.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomNavBar extends StatefulWidget {

  Color backgroundColor;

  CustomNavBar(Color backgroundColor);

  @override
  _CustomNavBarState createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {

  int _currentIndex = 1;
  final List<Widget> _children = [MyEventsScreen(),HomeScreen(),FavouritesScreen()];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          bottomAppBarColor: widget.backgroundColor,
          canvasColor: widget.backgroundColor,
          primaryColor: widget.backgroundColor,
          textTheme: Theme.of(context).textTheme.copyWith(
              caption: new TextStyle(color: widget.backgroundColor)
          ),
        ),
        child: new BottomNavigationBar(
          elevation: 0.0,
          fixedColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: new Image(image: AssetImage('images/Ticket.png'),height: 40.0,),
              activeIcon: new Image(image: AssetImage('images/TicketYellow.png'),height: 40.0,),
              title: new Text(''),
            ),
            BottomNavigationBarItem(
              icon: new Image(image: AssetImage('images/HomeBlack.png'),height: 40.0,),
              activeIcon: new Image(image: AssetImage('images/HomeYellow.png'),height: 40.0,),
              title: new Text(''),
            ),
            BottomNavigationBarItem(
              icon: new Image(image: AssetImage('images/Favourite.png'),height: 40.0,),
              activeIcon: new Image(image: AssetImage('images/FavouriteYellow.png'),height: 40.0,),
              title: new Text(''),
            ),
          ],
          onTap: onTabTapped,
        ),
      ),
      body: _children[_currentIndex],
    );
  }
}
