import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:hero_admin/main.dart';
import 'package:hero_admin/pages/account.dart';
import 'package:hero_admin/pages/help.dart';
import 'package:hero_admin/pages/home.dart';
import 'package:hero_admin/pages/homepage.dart';
import 'package:hero_admin/pages/inbox.dart';
import 'package:hero_admin/pages/job.dart';
import 'package:hero_admin/pages/login.dart';
import 'package:hero_admin/pages/review.dart';
import 'package:hero_admin/pages/setting.dart';

class Navigation extends StatefulWidget {


  @override

  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  StreamSubscription streamSubscription;


  PageController _myPage;
  var selectedPage;

  int _currentIndex = 2;

  void onTappedBar(int index){
    setState(() {
      _currentIndex = index;
      _myPage.jumpToPage(index);
    });
  }

  @override
  void initState() {
    super.initState();
    _myPage = PageController(initialPage: 2);
    selectedPage = 2;
  }

  @override
  dispose() {
    super.dispose();
    streamSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _myPage,
          children: <Widget>[
            Account(),
            Job(),
            HomePage(),
            Inbox(),
            Help(),
            Setting(),
          ],
        ),

        //body: _children[_currentIndex],
        bottomNavigationBar:
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: ConvexAppBar(
              backgroundColor: Color(0xFF93ca68),
            items: [
              TabItem(icon: Icons.account_circle, title: 'My Account'),
              TabItem(icon: Icons.card_travel, title: 'Jobs'),
              TabItem(icon: Icons.home, title: 'Home'),
              TabItem(icon: Icons.email, title: 'Inbox'),
              TabItem(icon: Icons.help, title: 'Help'),
            ],
            initialActiveIndex: _currentIndex,//optional, default as 0
            onTap:onTappedBar,
          ),
        )





        // bottomNavigationBar:BottomNavigationBar(
        //   currentIndex: _cIndex,
        //   backgroundColor: Color(0xFF93ca68),
        //   unselectedItemColor: Colors.white,
        //   selectedItemColor: Color(0xFF13869f),
        //   //type: BottomNavigationBarType.shifting ,
        //   type: BottomNavigationBarType.fixed ,
        //   items: [
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.account_circle ),
        //         title: new Text('My Account'),
        //     ),
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.card_travel),
        //         title: new Text('Jobs')
        //     ),
        //
        //     BottomNavigationBarItem(
        //       title: Text(''),
        //       icon: Container(
        //         height: 45,
        //         padding: EdgeInsets.fromLTRB(8,8,8,8),
        //         decoration: BoxDecoration(
        //           shape: BoxShape.circle,
        //           color: Colors.white,
        //         ),
        //         child: (
        //             Icon(Icons.home,size: 30,color: Color(0xFF93ca68))
        //         ),
        //       ),
        //     ),
        //
        //
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.email),
        //         title: new Text('Inbox')
        //     ),
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.help),
        //         title: new Text('Help')
        //     )
        //   ],
        //   onTap: (index){
        //     _incrementTab(index);
        //   },
        // )
    );
  }
}
