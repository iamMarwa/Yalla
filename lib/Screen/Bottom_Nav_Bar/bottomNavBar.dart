import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:yalla_activities/Screen/B1_Home/Home.dart';
import 'package:yalla_activities/Screen/B2_Category/B2_Category.dart';
import 'package:yalla_activities/Screen/B3_Manage_Event/B3_Manage_Event.dart';
import 'package:yalla_activities/Screen/B4_Profile/B4_Profile.dart';
import 'package:flutter/material.dart';

import '../B1_Home/choosplace_screen.dart';
import 'custom_nav_bar.dart';

class BottomNavBar extends StatefulWidget {
  final String idUser;
  int pageIndex=0;
   BottomNavBar({this.idUser,this.pageIndex});

  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex ;
  bool _color = true;
  Widget callPage(int current) {
    switch (current) {
      case 0:
        return 
        ChoosePalceScreen(currentUserId: widget.idUser,);
        //new showCaseHome(
          //userId: widget.idUser,
        //);
        //Category(
         // userId: widget.idUser,
        //);
        break;
      case 1:
        return new Category(
          userId: widget.idUser,
        );
        break;
      case 2:
        return new favorite(
          uid: widget.idUser,
        );
        break;
      case 3:
        return new profile(
          uid: widget.idUser,
        );
        break;
          case 4:
        return new showCaseHome(
          userId: widget.idUser,
        );
        break;
      default:
        return 
        ChoosePalceScreen(currentUserId: widget.idUser,);
        //new showCaseHome(
          //userId: widget.idUser,
        //);
    }
  }
@override
  void initState() {
    currentIndex=widget.pageIndex;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: callPage(currentIndex),
      bottomNavigationBar: BottomNavigationDotBar(
          // Usar -> "BottomNavigationDotBar"
          color: Colors.black26,
          items: <BottomNavigationDotBarItem>[
            BottomNavigationDotBarItem(
                icon: IconData(0xe900, fontFamily: 'home'),
                onTap: () {
                  setState(() {
                    currentIndex = 0;
                  });
                }),
            BottomNavigationDotBarItem(
                icon: IconData(0xe900, fontFamily: 'file'),
                onTap: () {
                  setState(() {
                    currentIndex = 1;
                  });
                }),
            BottomNavigationDotBarItem(
                icon: IconData(0xe900, fontFamily: 'hearth'),
                onTap: () {
                  setState(() {
                    currentIndex = 2;
                  });
                }),
            BottomNavigationDotBarItem(
                icon: IconData(0xe900, fontFamily: 'profile'),
                onTap: () {
                  setState(() {
                    currentIndex = 3;
                  });
                }),
          ]),
    );
  }
}
