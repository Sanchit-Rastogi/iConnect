import 'package:flutter/material.dart';
//import 'package:iConnect/views/tabs/addPost.dart';
//import 'package:iConnect/views/tabs/search.dart';
//import 'package:iConnect/views/tabs/feeds.dart';
//import 'package:iConnect/views/tabs/notifications.dart';
//import 'package:iConnect/views/tabs/profile.dart';
//import 'package:outline_material_icons/outline_material_icons.dart';

class NavbarWidget extends StatelessWidget {
//  final List<Widget> _pages = [
//    FeedsPage(),
//    SearchPage(),
//    NotificationsPage(),
//    ProfilePage(),
//    AddPostPage()
//  ];
//  void onTabTapped(int index) {
//    setState(() {
//      _currentIndex = index;
//    });
//  }

  final Function plusButtonTask;
  NavbarWidget({this.plusButtonTask});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFe4edec),
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          //_pages[_currentIndex],
          Positioned(
            bottom: 0.0,
            left: 10.0,
            right: 10.0,
            child: floatingBNB(),
          ),
          Positioned(
            bottom: 65.0,
            left: 10.0,
            right: 10.0,
            child: FloatingActionButton(
              backgroundColor: Color(0xffbbd1c5),
              onPressed: plusButtonTask,
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget floatingBNB() {
    void onTabTapped(int index) {
//      setState(() {
//        _currentIndex = index;
//      });
    }
    return Container(
      margin: EdgeInsets.only(bottom: 30.0, left: 10.0, right: 10.0),
      constraints: BoxConstraints.tightFor(height: 70.0),
      child: Material(
        borderRadius: BorderRadius.circular(35),
        color: Colors.white,
        elevation: 5.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.home,
                  color: Colors.black54,
                  size: 30.0,
                ),
                onPressed: () {
                  onTabTapped(0);
                }),
            IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.black54,
                  size: 30.0,
                ),
                onPressed: () {
                  onTabTapped(1);
                }),
            SizedBox(
              width: 10.0,
            ),
            IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: Colors.black54,
                  size: 30.0,
                ),
                onPressed: () {
                  onTabTapped(2);
                }),
            IconButton(
                icon: Icon(
                  Icons.person,
                  color: Colors.black54,
                  size: 30.0,
                ),
                onPressed: () {
                  onTabTapped(3);
                }),
          ],
        ),
      ),
    );
  }
}
