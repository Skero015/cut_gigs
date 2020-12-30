import 'package:cut_gigs/config/styleguide.dart';
import 'package:cut_gigs/screens/FavouritesScreen.dart';
import 'package:cut_gigs/screens/HomeScreen.dart';
import 'package:cut_gigs/screens/MyEventsScreen.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomNavBar extends StatefulWidget {

  CustomNavBar();

  @override
  _CustomNavBarState createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {

  int _currentIndex = 1;
  final List<Widget> _children = [MyEventsScreen(),HomeScreen(),FavouritesScreen()];


  @override
  Widget build(BuildContext context) {

    void onTabTapped(int index) {
      setState(() {
        _currentIndex = index;
      });
    }

    return Scaffold(
      backgroundColor: _currentIndex == 0 ? Colors.white : Colors.transparent,
      bottomNavigationBar: new BottomNavigationBar(
        elevation: _currentIndex == 0 ? 7.0 : 0.0,
        fixedColor: _currentIndex == 0 ? Colors.white : Colors.transparent,
        backgroundColor: _currentIndex == 0 ? Colors.white : Colors.transparent,
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
      body: _children[_currentIndex],
    );
  }
}
