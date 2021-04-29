import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yalla_activities/Library/bubbleTabCustom/bubbleTab.dart';
import 'package:yalla_activities/Screen/B1_Home/Home_Search/search_page.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'category/allBicycling.dart';
import 'category/Intermediate.dart';
import 'category/advanced.dart';
import 'category/Beginner.dart';

class Bicycling extends StatefulWidget {
  String userId;
  Bicycling({this.userId});

  _BicyclingState createState() => _BicyclingState();
}

class _BicyclingState extends State<Bicycling> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 60.0,
                  ),
                  Expanded(
                    child: DefaultTabController(
                      length: 4,
                      child: new Scaffold(
                        backgroundColor: Colors.white,
                        appBar: PreferredSize(
                          preferredSize:
                              Size.fromHeight(40.0), // here the desired height
                          child: new AppBar(
                              backgroundColor: Colors.transparent,
                              elevation: 0.0,
                              centerTitle: true,
                              automaticallyImplyLeading: false,
                              title: new TabBar(
                                indicatorSize: TabBarIndicatorSize.tab,
                                unselectedLabelColor: Colors.black12,
                                labelColor: Colors.white,
                                labelStyle: TextStyle(fontSize: 19.0),
                                indicator: new BubbleTabIndicator(
                                  indicatorHeight: 36.0,
                                  indicatorColor: Color(0xFF928CEF),
                                  tabBarIndicatorSize: TabBarIndicatorSize.tab,
                                ),
                                tabs: <Widget>[
                                  new Tab(
                                    child: Text(
                                      "All",
                                      style: TextStyle(
                                        fontSize: 11.2,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  new Tab(
                                    child: Text(
                                      "Beginner",
                                      style: TextStyle(
                                        fontSize: 11.5,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  new Tab(
                                    child: Text(
                                      "Intermediate",
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  new Tab(
                                    child: Text(
                                      "Advanced",
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        body: new TabBarView(
                          children: [
                            allBicycling(
                              idUser: widget.userId,
                            ),
                            beginner(
                              idUser: widget.userId,
                            ),
                            intermediate(
                              idUser: widget.userId,
                            ),
                            advanced(
                              idUser: widget.userId,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 40.0,
              left: 20.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.clear)),
                Text(
                  "Bicycling",
                  style: TextStyle(
                      fontFamily: "Sofia",
                      fontWeight: FontWeight.w800,
                      fontSize: 25.0,
                      letterSpacing: 0.8,
                      color: Colors.black),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (_, __, ___) => new SearchPage(
                                  idUser: widget.userId,
                                )));
                      },
                      child: Icon(
                        Icons.search,
                        size: 28.0,
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
